//
//  String+Extension.swift
//  BaoKanIOS
//
//  Created by jianfeng on 16/2/22.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     时间戳转为时间
     
     - returns: 时间字符串
     */
    func timeStampToString() -> String {
        let string = NSString(string: self)
        let timeSta: TimeInterval = string.doubleValue / 1000.0
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    /**
     时间戳转为NSDate
     
     - returns: NSDate
     */
    func timeStampToDate() -> Date {
        let string = NSString(string: self)
        let timeSta: TimeInterval = string.doubleValue
        let date = Date(timeIntervalSince1970: timeSta)
        return date
    }
    
    /**
     时间转为时间戳
     
     - returns: 时间戳字符串
     */
    func stringToTimeStamp() -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: self)
        let dateStamp: TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
    }
    
    
    /**
     时间戳处理(当前时间比较)
     
     - returns: 对比时间
     */
    func compareCurrentTime() -> String {
        let string = NSString(string: self)
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let timeDate = formatter.date(from: string as String)
        let currentDate = Date()
        let timeInterval: TimeInterval = currentDate.timeIntervalSince(timeDate!)
        
        var temp: Double = 0
        var result = String()
        if (timeInterval/60 < 1) {
            result = "刚刚"
        }else if ((timeInterval/60)<60){
            temp = timeInterval/60
            result = String(format:"%ld分钟前", Int(temp))
            
        }else if ((timeInterval/60/60)<24){
            temp = timeInterval/60/60
            result = String(format:"%ld小时前", Int(temp))
            
        }else if ((timeInterval/60/60/24)<30){
            temp = timeInterval/60/60/24
            result = String(format:"%ld天前", Int(temp))
            
        }else if ((timeInterval/60/60/24/30)<12){
            temp = timeInterval/60/60/24/30
            result = String(format:"%ld月前", Int(temp))
            
        }else{
            temp = timeInterval/60/60/24/30/12;
            result = String(format:"%ld年前", Int(temp))
        }
    
        return result
    }
    
    
    /**
     传入cell文本内容，解析成元素为昵称的数组
     
     - returns: 昵称数组
     */
    func checkAtUserNickname() -> [String]? {
        do {
            let pattern = "@\\S*"
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let results = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count))
            
            var resultStrings = [String]()
            for result in results {
                resultStrings.append(String((self as NSString).substring(with: result.range)))
            }
            return resultStrings
        }
        catch {
            return nil
        }
    }
    
    
    func validNumber() -> Bool{
        
        do {
            let pattern = "^[0-9]*$"
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let results = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count))
            
            return results.count > 0
            
        }catch {
            return false
        }
        
    }
    
    func validIDCardNumber() -> Bool{
        
        do {
            let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let results = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count))
            
            return results.count > 0
            
        }catch {
            return false
        }
    }
    
    func getTextHeigh(font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText = NSString.init(string: self)
        let size = CGSize(width: width, height: 1000)
        let dic:[String: AnyObject] = [NSFontAttributeName: font]
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context:nil).size
        return stringSize.height
    }
    
    func getTexWidth(font:UIFont,height:CGFloat) -> CGFloat {
        
        let normalText = NSString.init(string: self)
        let size = CGSize(width: 1000, height: height)
        
        let dic:[String: AnyObject] = [NSFontAttributeName: font]
        
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context:nil).size
        
        return stringSize.width
        
    }
}
