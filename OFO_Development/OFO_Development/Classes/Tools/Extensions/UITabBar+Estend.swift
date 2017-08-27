//
//  UITabBar+Estend.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/3/7.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import Foundation
import UIKit

private let baseTag: Int = 1000
private let TabbarItemNums: Int = Int(4.0) //tabBar的数量


extension UITabBar {

    // MARK:- 设置显示Badge
    func showBadgeOnItemIndex(_ index: Int) {
        
        let badgeView = UIView.init()
        badgeView.backgroundColor = UIColor.red
        badgeView.tag = baseTag + index

        var x = CGFloat()
        let wid: CGFloat = 10;
        let tabBarWid = self.frame.size.width
        let y = 0.1 * self.frame.size.height
        
        if iPhoneModel.getCurrentModel() == iPhoneModel.iPhone4 {
            
            x = tabBarWid * 0.4;
        }
        if iPhoneModel.getCurrentModel() == iPhoneModel.iPhone5 {
            
            x = tabBarWid * 0.4;
        }
        if iPhoneModel.getCurrentModel() == iPhoneModel.iPhone6 {
            
            x = tabBarWid * 0.4;
        }
        if iPhoneModel.getCurrentModel() == iPhoneModel.iPhone6p {
            
            x = tabBarWid * 0.4;
        }
        
        badgeView.frame = CGRect(x: x, y: y, width: wid, height: wid)
        badgeView.layer.cornerRadius = badgeView.layer.frame.size.height*0.5
        badgeView.clipsToBounds = true
        self.addSubview(badgeView)
    }
    
    
    // MARK:- 隐藏小红点
    func hideBadgeOnItemIndex(_ index: Int) {
        
        //移除小红点
        self.removeBadgeOnItemIndex(index)
    }
    
    
    // MARK:- 移除小红点
    func removeBadgeOnItemIndex(_ index: Int) {
        
        for subView in self.subviews {
            
            if subView.tag == baseTag+index {
    
                subView.removeFromSuperview()
            }
        }
    }
}

