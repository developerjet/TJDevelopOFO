//
//  XDAlert+Extension.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/15.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import Foundation
import UIKit

class XDAlert: NSObject {
    
    static let API = XDAlert()
    
    private override init() {}
}


// MARK:- 自定义Alert样式
extension XDAlert {
    
    ///1.点击不响应提示框
    func normalAlert(title: String, message: String) {
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "确定")
        
        alert.show()
    }
    
    
    ///2.带确认的提示框
    func sourceAlert(title: String, message: String, vc: UIViewController, source: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        ///2.1设置两个UIAlertAction
        let confirmAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            source()
        }
        let cleanAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        //添加
        alertController.addAction(confirmAction)
        alertController.addAction(cleanAction)
        
        //展示Alert
        vc.present(alertController, animated: true, completion: nil)
    }
    
    ///3.完全自定义样式的Alert
    func customAlert(title: String, message: String, confir: String, clean: String, vc: UIViewController, source: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        ///2.1设置两个UIAlertAction
        let confirmAction = UIAlertAction(title: confir, style: .default) { (UIAlertAction) in
            source()
        }
        let cleanAction = UIAlertAction(title: clean, style: .cancel, handler: nil)
        
        //添加
        alertController.addAction(confirmAction)
        alertController.addAction(cleanAction)
        
        //展示Alert
        vc.present(alertController, animated: true, completion: nil)
    }
    
    ///4.带UITextField的提示框
    func textFiledAlert(title: String, message: String, placeholder: String, vc: UIViewController, source: @escaping (_ text: String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textFiled: UITextField) in
            textFiled.placeholder = placeholder
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            let login = alertController.textFields![0]
            source(login.text!)
            print("输入的是：\(login.text)")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }
}


// MARK:- 使用示例

/**
 ①：XDAlert.API.normalAlert(title: "温馨提示", message: indexStr)
 
 ②：XDAlert.API.sourceAlert(title: "温馨提示", message: indexStr, vc: self) {
        print("点击了确认")
    }
 
 ③：XDAlert.API.customAlert(title: "收到最新消息", message: message, confir: "查看", clean: "忽略", vc:windowKey!, source: {
        XDLog("前台收到推送消息...")
    })
 
 
 ④：XDAlert.API.TextFiledAlert(title: "温馨提示", message: indexStr, placeholder: "请编辑你的信息", vc: self) { (String) in
        print(String)
    }
 */
