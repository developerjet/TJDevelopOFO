//
//  NSString+Estend.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/17.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

extension String {
    
    // MARK:-  字符输入长度限制
    func trimAll(_ trim: String, rangeCount: Int) -> Bool {
        
        if (trim.lengthOfBytes(using: String.Encoding.utf8) == rangeCount) {
            let alert = String(format: "输入限制为%d个字符", rangeCount)
            
            //XDHUD.FTErrorShow(alert)
            return false
        }else {
            return true
        }
    }
    
    // MARK: 手机号正则表达式
    func validateMobile() -> Bool {
        let phoneRegex = try? NSRegularExpression(pattern: "^1(3[0-9]|5[0-35-9]|8[02345-9]|70|77)\\d{8}$", options: NSRegularExpression.Options.caseInsensitive)
        return phoneRegex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }

    // MARK:- 图形验证码正则表达式
    func validatePicture() -> Bool {
        let pictureCodeRegex: String = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{4}"
        let pictureCodeTest = NSPredicate(format: "SELF MATCHES", pictureCodeRegex)
        return pictureCodeTest.evaluate(with: self)
    }
    
    // MARK: 邮箱正则表达式
    func validateEmail() -> Bool {
        let emailRegex = try? NSRegularExpression(pattern: "[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?", options: NSRegularExpression.Options.caseInsensitive)
        return emailRegex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
    // MARK: 密码正则表达式（6-16位密码且包含英文字母和数字组合，不能使用特殊字符）
    func validatePassword() -> Bool {
        let passwordRegex: String = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
    
    // MARK: 邮政编码正则表达式（中国邮政编码为6位数字）
    func validateZipCode() -> Bool {// [1-9]\d{5}(?!\d)$
        let zipCodeRegex: String = "[1-9]\\d{5}(?!\\d)$"
        let zipCodeTest = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        return zipCodeTest.evaluate(with: self)
    }
    
}
