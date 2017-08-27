//
//  NavBarItem+Extension.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/14.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import Foundation
import UIKit


extension UIBarButtonItem {
    
    // MARK:- 快速设置导航条UIBarButtonItem+Title
    class func setNavItemWithTitle(normalNamed: String, highlightNamed: String, title: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        
        let customBtn = UIButton.init(type: .custom)
        customBtn.setTitle(title, for: .normal)
        customBtn.setTitleColor(UIColor.black, for: .normal)
        customBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        customBtn.setTitle(normalNamed, for: .normal)
        customBtn.setImage(UIImage.init(named: highlightNamed), for: .highlighted)
        customBtn.sizeToFit()
        customBtn.addTarget(target, action: action, for: .touchUpInside)
        
        let customView = UIView.init(frame: customBtn.bounds)
        customView.addSubview(customBtn)
        
        return UIBarButtonItem.init(customView: customView)
    }
    
    
    // MARK:- 快速设置导航条UIBarButtonItem
    class func setNavItems(normalNamed: String, highlightNamed: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        
        let customBtn = UIButton.init(type: .custom)
        customBtn.setImage(UIImage.init(named: normalNamed), for: .normal)
        customBtn.setImage(UIImage.init(named: highlightNamed), for: .highlighted)
        customBtn.sizeToFit()
        customBtn.addTarget(target, action: action, for: .touchUpInside)
        
        let customView = UIView.init(frame: customBtn.bounds)
        customView.addSubview(customBtn)
        
        return UIBarButtonItem.init(customView: customView)
    }
    
    
    class func setNavItem(normalNamed: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        
        let customBtn = UIButton.init(type: .custom)
        customBtn.setImage(UIImage.init(named: normalNamed), for: .normal)
        customBtn.sizeToFit()
        customBtn.addTarget(target, action: action, for: .touchUpInside)
        
        let customView = UIView.init(frame: customBtn.bounds)
        customView.addSubview(customBtn)
        
        return UIBarButtonItem.init(customView: customView)
    }
    
}
