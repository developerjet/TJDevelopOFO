//
//  XDHUD.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/15.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import SVProgressHUD
import FTIndicator

class XDHUD: NSObject {
    
    // MARK:- HUD初始化设置
    @objc override class func initialize () {
       super.initialize()
        
        initializeHUD()
        initialFTHUD()
    }
    
    class func initializeHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.hudBackgroundColor())
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 13))
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
    }
    
    
    class func initialFTHUD() {
        
        FTIndicator.setIndicatorStyle(.dark)
    }
    
    // MARK:- 具体样式设置
    ///普通的菊花HUD
    class func show() {
        SVProgressHUD.show()
    }
    
    ///带文字的菊花HUD
    class func showWithStatus(_ status: String) {
     
        SVProgressHUD.show(withStatus: status)
    }
    
    ///带警告的HUD
    class func showWithInfo(_ status: String) {
        
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    ///成功提示HUD
    class func showWithSuccess(_ success: String) {
        
        SVProgressHUD.showSuccess(withStatus: success)
    }
    
    ///失败提示HUD
    class func showWithError(_ error: String) {
        
        SVProgressHUD.showError(withStatus: error)
    }
    
    ///带加载进度提示的HUD
    class func showWithProgress(_ status: Float) {
        
        SVProgressHUD.showProgress(status)
    }
    
    ///HUD消失
    class func hide() {
        
        SVProgressHUD.dismiss()
    }
}

extension XDHUD {
    
    /// 成功
    class func FTSuccessShow(_ message: String) {
        
        FTIndicator.showSuccess(withMessage: message)
    }
    
    /// 失败
    class func FTErrorShow(_ message: String) {
        
        FTIndicator.showError(withMessage: message)
    }
    
    /// 带菊花提示
    class func FTShowToastMessage(_ message: String){
        
        FTIndicator.showToastMessage(message)
    }
    
    class func FTShowProgress(_ message: String) {
        
        FTIndicator.showProgressWithmessage(message)
    }
    
    /// 通知类提示(带图片)
    class func FTShowNotiImage(_ image: UIImage, title: String, message: String) {
        
        FTIndicator.showNotification(with: image, title: title, message: message)
    }
    
    /// 普通通知类提示
    class func FTShowNotiMessage(_ title: String, message: String) {
        
        FTIndicator.showNotification(withTitle: title, message: message)
    }
    
    /// 隐藏所有HUD
    class func FTDissmiss() {
        
        FTIndicator.dismissToast()
        FTIndicator.dismissProgress()
        FTIndicator.dismissNotification()
    }
}
