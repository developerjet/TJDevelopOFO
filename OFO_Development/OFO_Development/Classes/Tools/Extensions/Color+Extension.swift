//
//  Color+Tools.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/14.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK:- 16进制转化Color
    class func colorWithHexStr(_ hex:String) ->UIColor {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasSuffix("#")) {
            
            let index = cString.index(cString.startIndex, offsetBy: 1)
            
            cString = cString.substring(from: index)
        }
        
        if (cString.characters.count != 6) {
            
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: (1))
    }
    
    
    /// 16进制转化Color
    ///
    /// - Parameters:
    ///   - hex: 16进制
    ///   - alpha: 透明度
    /// - Returns: Color
    class func colorWithHexString(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    
    // MARK:- RGB的颜色设置
    class func RGB(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/1.0)
    }
    
    // MARK:- 随机颜色
    class func randomColor() -> UIColor {

        let red = CGFloat(arc4random_uniform(256))
        let green = CGFloat(arc4random_uniform(256))
        let blue = CGFloat(arc4random_uniform(256))

        return RGB(r: red, g: green, b: blue, a: 1)
    }
    
    // MARK:- 应用控件主题背景色
    class func mainHexColor() ->UIColor {
        
        return self.colorWithHexStr("FFFFFF")
    }
    
    // MARK:- View背景色
    class func backGroundHexColor() ->UIColor {
        
        return self.colorWithHexStr("F8F8F8")
    }
    
    // MARK:- 应用主体字体颜色
    class func textDrakHexColor() -> UIColor {
        
        return self.colorWithHexStr("323232")
    }
    
    // MARK:- 背景色和线条
    class func textLightHexColor() -> UIColor {
        
        return self.colorWithHexStr("989898")
    }
    
    // MARK:- 分割线
    class func boardLineColor() -> UIColor {
        
        return self.colorWithHexStr("e8e8e8")
    }
    
    // MARK:- 注册协议的字体颜色
    class func registerProtocolColor() -> UIColor {
        
        return self.colorWithHexStr("ff9850")
    }
    
    // MARK:- UISwitch开关的颜色
    class func switchColor() -> UIColor {
        
        return self.colorWithHexStr("fbb65e")
    }
    
    // MARK:- 登录注册按钮背景颜色
    class func btnBackgroundColor() -> UIColor {
        
        return self.colorWithHexStr("FEE800")
    }
    
    
    // MARK:- 导航条颜色
    class func navigationBarColor() -> UIColor {
        
        return RGB(r: 236, g: 185, b: 103, a: 1)
    }
    
    // MARK:- HUD的背景颜色
    class func hudBackgroundColor() -> UIColor {
        
        return RGB(r: 36, g: 36, b: 36, a: 0.7)
    }
    
}
