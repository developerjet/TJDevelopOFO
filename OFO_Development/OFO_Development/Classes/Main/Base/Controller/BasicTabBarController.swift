//
//  BasicTabBarController.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/14.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

let noticesNewsRefresh = "noticesNewsRefresh"

class BasicTabBarController: UITabBarController {
    
    var lastViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewControllers()
    }

    
    // MARK:- 设置UITabBarItem文字属性
    override class func initialize() {
    
        setUpItemAttribute()
    }
    
    
    class func setUpItemAttribute() {
        
        let item = UITabBarItem.appearance()
        
        //普通状态下文字属性
        var normAttribute = [String : Any]()
        normAttribute[NSFontAttributeName] = UIFont.systemFont(ofSize: 10)
        normAttribute[NSForegroundColorAttributeName] = UIColor.colorWithHexStr("aaaaaa")
        item.setTitleTextAttributes(normAttribute, for: .normal)
        
        //选中状态下文字属性
        var selectorAttribute = [String : Any]()
        selectorAttribute[NSFontAttributeName] = UIFont.systemFont(ofSize: 10)
        selectorAttribute[NSForegroundColorAttributeName] = UIColor.colorWithHexStr("fbb65e")
        item.setTitleTextAttributes(selectorAttribute, for: .selected)
    }
    
    // MARK: - 添加子控制器
    fileprivate func addChildViewControllers() {
        
        ///首页
        addChildController(HomeMapViewController(), tabBarTitle: "首页", normImage: "icon_home", selectorImage: "icon_home_click")
        
        ///我的
        addChildController(MineViewController(), tabBarTitle: "我的", normImage: "icon_news", selectorImage: "icon_news_click")
                
        ///设置代理
        self.delegate = self;
        
        ///消息界面
        self.lastViewController = self.childViewControllers[1]
    }
    
    
    func addChildController(_ childController: UIViewController, tabBarTitle: String, normImage: String, selectorImage: String) {
        
        //设置图片(防止被渲染)
        childController.title = tabBarTitle
        childController.tabBarItem.image = UIImage(named: normImage)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectorImage)?.withRenderingMode(.alwaysOriginal)
        
        let basicNav = BasicNavigationController(rootViewController: childController)
        addChildViewController(basicNav)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension BasicTabBarController: UITabBarControllerDelegate {

    /// 每次选中消息(刷新消息列表)
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let nav = viewController as! BasicNavigationController
        
        if (self.selectedIndex == 1) {
            
            let message = nav.viewControllers[0] as! MineViewController
            
            //message.beginRefresh()
        }
    }
}

