//
//  BasicNavigationController.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/14.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

class BasicNavigationController: UINavigationController {

    var pan = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        
        //禁用系统自带的左侧返回手势
        self.interactivePopGestureRecognizer?.isEnabled = false
        
        let target = self.interactivePopGestureRecognizer?.delegate
        
        //添加全屏滑动返回手势
        let returnSelector = NSSelectorFromString("handleNavigationTransition:") as Selector?
        
        self.pan.addTarget(target!, action: returnSelector!)
        
        self.view.addGestureRecognizer(pan)
        
        self.delegate = self
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .default
    }
    
    @objc override class func initialize() {
        
        setUpNavigationBar()
    }
    
    // MARK:- 设置导航条文字属性
    class func setUpNavigationBar() {
        
        let navBar = UINavigationBar.appearance()
        
        var navAttribute = [String : Any]()
        navAttribute[NSFontAttributeName] = UIFont.systemFont(ofSize: 17)
        navAttribute[NSForegroundColorAttributeName] = UIColor.white
        navBar.titleTextAttributes = navAttribute
        
        //设置导航条颜色
        navBar.barTintColor = UIColor.btnBackgroundColor()
        navBar.tintColor = .white
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.setNavItem(normalNamed: "popBack", target: self, action: #selector(navigationReturn))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    // MARK:- 返回处理
    func navigationReturn(){
        
        self.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension BasicNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        if navigationController.viewControllers.count > 1 {
            
            self.pan.isEnabled = true
            
        }else {

            self.pan.isEnabled = false
        }
        
        //交互上不允许侧滑返回的控制器
        if viewController is BasicWebViewController {
            
            self.pan.isEnabled = false
        }
    }
    
}
