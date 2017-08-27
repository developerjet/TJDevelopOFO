//
//  AppDelegate.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/12.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import AVOSCloud
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var drawer = MMDrawerController()
    
    // MARK:- 全局的导航控制器
    var currentNav: UINavigationController? {
        
        get{
            let tabBar = UIApplication.shared.keyWindow?.rootViewController
            
            if !(tabBar is UITabBarController){return nil}
            
            let nav =  (tabBar as! UITabBarController).selectedViewController
            
            return nav as? UINavigationController
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setRootIsDrawer()
        registerSDK()
        
        return true
    }

    
    func setRootIsDrawer() {
        
        let leftViewController = SideBarViewController()
        let centerViewController = HomeMapViewController()
        let centerNav = BasicNavigationController.init(rootViewController: centerViewController)
        
        // 设置左控制器
        drawer = MMDrawerController.init(center: centerNav, leftDrawerViewController: leftViewController)
        
        // 侧拉距离
        drawer.maximumLeftDrawerWidth = 0.7 * screenWidth
        
        // 手势
        drawer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        drawer.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        //设置动画，这里是设置打开侧栏透明度从0到1
        drawer.setDrawerVisualStateBlock { (drawerController, drawerSide, percentVisible) -> Void in
            
            var sideDrawerViewController:UIViewController?
            if(drawerSide == MMDrawerSide.left){
                sideDrawerViewController = drawerController?.leftDrawerViewController;
            }
            
            sideDrawerViewController?.view.alpha = percentVisible
        }
        
        
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = drawer
        
        self.window?.makeKeyAndVisible() //打开窗口
    }
}


extension AppDelegate {
    
    func registerSDK() {
    
        /// MAP
        AMapServices.shared().apiKey = MAMapKey
        AMapServices.shared().enableHTTPS = true

        /// LearnCold
        AVOSCloud.setApplicationId("wK3P1hUVeaSPAornnwz9RsL1-gzGzoHsz", clientKey: "x2a18pWra71wdSTOl4qr7fB4")
    }

}



