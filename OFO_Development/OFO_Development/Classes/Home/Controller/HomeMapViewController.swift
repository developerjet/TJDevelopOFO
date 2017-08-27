//
//  HomeMapViewController.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/12.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import SnapKit
import MMDrawerController
import FTIndicator


class HomeMapViewController: XDBasicViewController {

    // MARK: - Property
    var search: AMapSearchAPI!
    var pinView: MAPinAnnotationView!
    var pin: MyPinAnnotation!
    
    var start, end: CLLocationCoordinate2D!
    
    var nearbySearch = true
    
    // MARK: - LazyLoad
    lazy var mapView: MAMapView = {
        let map = MAMapView.init(frame: self.view.bounds)
        map.delegate = self
        map.zoomLevel = 17
        map.showsUserLocation = true //持续追踪
        map.userTrackingMode = .follow
        return map
    }()
    
    lazy var walkManager: AMapNaviWalkManager = {
        let manager = AMapNaviWalkManager()        
        manager.delegate = self
        return manager
    }()
    
    // MARK: - LoadAll
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNav()
        initMap()
        
        initSearch()
    }
    
    func initNav() {
    
        let image = UIImage.init(named: "title_105x22")
        self.navigationItem.titleView = UIImageView(image: image)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.setNavItem(normalNamed: "leftItme", target: self, action: #selector(leftClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.setNavItem(normalNamed: "rightItem", target: self, action: #selector(webClick))
    }
    
    // MARK: - 展示侧边栏
    func leftClick() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawer.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    func webClick() {
        let web = BasicWebViewController()
        web.webURL = "https://m.ofo.so/active.html"
        web.webName = "热门话题"
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    // MARK: - Map
    func initMap() {
        
        view.addSubview(mapView)
        
        if let toolsView = MapToolsView.loadToolsView() {
            view.addSubview(toolsView);
            view.bringSubview(toFront: toolsView)
            toolsView.snp.makeConstraints({ (make) -> Void in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(self.view.frame.size.height * 0.25) //高度是屏幕的1/4
            })
            
            /// 设置代理
            toolsView.delegate = self
        }
    }
    
    // MARK: - Search
    func initSearch() {
        
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    // MARK: - 搜索附近的小黄车
    func startSearchNearBy() {

        searchCustomLocation(mapView.userLocation.coordinate)
    }
    
    func searchCustomLocation(_ center: CLLocationCoordinate2D) {
    
        let request = AMapPOIAroundSearchRequest()
        //request.tableID = TableID
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        request.keywords = "餐馆"
        request.radius = 500
        request.requireExtension = true
        
        /// 发起周边检索
        search.aMapPOIAroundSearch(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - MAMapViewDelegate
extension HomeMapViewController: MAMapViewDelegate {
    
    /// 地图初始化完成
    func mapInitComplete(_ mapView: MAMapView!) {
        /// 开始搜索
        startSearchNearBy()
        
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        pin.isLockedToScreen = true
        
        ///添加到屏幕中心
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
    }
    
    /// 用户移动地图
    func mapView(_ mapView: MAMapView!, mapWillMoveByUser wasUserAction: Bool) {
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            /// 移动之后检索
            searchCustomLocation(mapView.centerCoordinate)
        }
    }
    
    /// 地图上标注的动画
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        let aViews = views as! [MAAnnotationView]
        
        for aView in aViews {
            guard aView.annotation is MAPinAnnotationView else {
                continue
            }
            
            aView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveLinear, animations: {
                aView.transform = .identity //恢复大小
            }, completion: nil)
        }
    }
    
    func pinAnimation() {
        
        let endFrame = pinView.frame
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        
        // UIViewAnimationOptionCurveLinear
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    
    /// 点击地图上标注
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        start = pin.coordinate
        end = view.annotation.coordinate
        
        /// 初始化高德地图的两个点
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(end.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
        
        /// 计算步行规划路线
        walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
    }
    
    /// 设置大头针的标注视图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - annotation: 标注
    /// - Returns: 大头针的标注视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        /// 用户定义的位置，不需要自定义
        if annotation is MAUserLocation {
            return nil
        }
        
        if annotation is MyPinAnnotation {
            let reuseid = "anchor"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid)
            
            if av == nil {
                
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            }
            
            av?.image = #imageLiteral(resourceName: "HomePage_wholeAnchor")
            
            av?.canShowCallout = false
            //av?.animatesDrop = false
            
            pinView = av as! MAPinAnnotationView
            return av
        }
        
        let reuseid = "myid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
        
        if annotationView == nil {
            
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
        }
        
        if annotation.title == "红包车" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_ParkRedPack")
        }
        else if annotation.title == "附近可用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        }
        
        /// 允许弹出标识
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        
        return annotationView
    }
    
    /// 路线规划划线
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline {
            pin.isLockedToScreen = false //锁定大头针位置

            mapView.visibleMapRect = overlay.boundingMapRect
            
            let renderer = MAPolylineRenderer(overlay: overlay)
            renderer?.lineWidth = 5.0
            renderer?.strokeColor = UIColor.red
            
            return renderer
        }
        
        return nil
    }
    
}

// MARK: - AMapNaviWalkManagerDelegate
extension HomeMapViewController: AMapNaviWalkManagerDelegate {
    
    /// 路线规划处理结果
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        //XDHUD.showWithSuccess("路线规划成功")
        mapView.removeOverlays(mapView.overlays)
        
        /// 显示路径或开启导航
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        
        let polyline = MAPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        
        mapView.add(polyline)
        
        /// 提示距离和用时
        let walkMinute = walkManager.naviRoute!.routeTime / 60
        
        var timeDesc = "1分钟以内"
        if walkMinute > 0 {
            
            timeDesc = walkMinute.description + "分钟"
        }
        
        let hintTitle = "步行" + timeDesc
        let hintSubtitle = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
        //XDAlert.API.normalAlert(title: hintTitle, message: hintSubtitle)
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "TimeIcon_17x17"), title: hintTitle, message: hintSubtitle)
    }
    
    func walkManager(_ walkManager: AMapNaviWalkManager, error: Error) {
        
        print(error)
    }
}

// MARK: - AMapSearchDelegate
extension HomeMapViewController: AMapSearchDelegate {

    /// 搜索周边完成后的回调处理
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        guard response.count > 0  else {
            XDHUD.FTErrorShow("没有找到附近小黄车")
            return
        }
        
        /// 解析response获取POI信息
        var annotations: [MAPointAnnotation] = []
        
        annotations = response.pois.map {
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))

            if $0.distance < 400 {
                annotation.title = "红包车";
                annotation.subtitle = "骑行超过10分钟获得现金红包"
            }else {
                annotation.title = "附近可用"
                annotation.subtitle = "赶快去骑行吧"
            }
            
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        
        if nearbySearch {
            mapView.showAnnotations(annotations, animated: true)
            nearbySearch = !nearbySearch
        }

    }
}

// MARK: - MapToolsProtocol
extension HomeMapViewController: MapToolsProtocol {
    func toolsDidItemLocation() {
     
        nearbySearch = true
        startSearchNearBy()
    }

    func toolsDidItemScan() {
        
        let scan = ScanViewController()
        self.navigationController?.pushViewController(scan, animated: true)
    }
    
    func toolsDidItemCase() {
        
        print("吐槽啊")
    }
}

