//
//  XDSwiftPch.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/16.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import AudioToolbox

// MARK:- 屏幕尺寸获取(屏幕适配)
let screenBounds = UIScreen.main.bounds.size
let screenWidth = screenBounds.width
let screenHeight = screenBounds.height


/// 基于iPhone6垂直方向适配
///
/// - Parameter size: iPhone6垂直方向尺寸
/// - Returns: 其他型号尺寸
func layoutVertical(iPhone6: CGFloat) -> CGFloat {
    
    var newHeight: CGFloat = 0
    
    switch iPhoneModel.getCurrentModel() {
    case .iPhone5:
        newHeight = iPhone6 * (568.0 / 667.0)
    case .iPhone6:
        newHeight = iPhone6
    case .iPhone6p:
        newHeight = iPhone6 * (736.0 / 667.0)
    default:
        newHeight = iPhone6 * (1024.0 / 667.0 * 0.9)
    }
    
    return newHeight
    
}

/// 基于iPhone6水平方向适配
///
/// - Parameter iPhone6: iPhone6水平方向尺寸
/// - Returns: 其他型号尺寸
func layoutHorizontal(iPhone6: CGFloat) -> CGFloat {
    
    var newWidth: CGFloat = 0
    
    switch iPhoneModel.getCurrentModel() {
    case .iPhone5:
        newWidth = iPhone6 * (320.0 / 375.0)
    case .iPhone6:
        newWidth = iPhone6
    case .iPhone6p:
        newWidth = iPhone6 * (414.0 / 375.0)
    default:
        newWidth = iPhone6 * (768.0 / 375.0 * 0.9)
    }
    
    return newWidth
    
}

/// 基于iPhone6字体的屏幕适配
///
/// - Parameter iPhone6: iPhone字体大小
/// - Returns: 其他型号字体
func layoutFont(iPhone6: CGFloat) -> CGFloat {
    
    var newFont: CGFloat = 0
    
    switch iPhoneModel.getCurrentModel() {
    case .iPhone5:
        newFont = iPhone6 * (320.0 / 375.0)
    case .iPhone6:
        newFont = iPhone6
    case .iPhone6p:
        newFont = iPhone6 * (414.0 / 375.0)
    default:
        newFont = iPhone6 * 1.2
    }
    
    return newFont
}

/**
 手机型号枚举
 */
enum iPhoneModel {
    
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPad
    
    /**
     获取当前手机型号
     
     - returns: 返回手机型号枚举
     */
    static func getCurrentModel() -> iPhoneModel {
        switch screenHeight {
        case 480:
            return .iPhone4
        case 568:
            return .iPhone5
        case 667:
            return .iPhone6
        case 736:
            return .iPhone6p
        default:
            return .iPad
        }
    }
}


// MARK:- 高德地图Key
let MAMapKey = "1575370311acf91ad7ba044980361641"

// MARK:- 获取版本信息
let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let sysVersionCount = (currentVersion as NSString).floatValue

// MARK:- 清除图片缓存
func cleanFileSize() {
    
    // 用异步的方式运行队列里的任务
    DispatchQueue.global(qos: .userInitiated).async {
        
        let manager: FileManager = FileManager.default
        
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        let files: String = cachePath! + "/default"
        let flBool: Bool = manager.fileExists(atPath: files)
        
        if(flBool == false) {
            return
        }else {
            
            do{
                try manager.removeItem(atPath: files)
            }catch {
                print(error)
            }
        }

    }
}

// MARK: - 首页地图工具区分
enum ToolsDidItemType: UInt {
    case ToolsDidItemLocation = 1000
    case ToolsDidItemCase = 1001
    case ToolsDidItemScan = 1002
}


// MARK: - AppDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate


// MARK:- 异步播放通知音效
func asyncPlaySound() {
    
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now(), execute: {
        
        var soundID: SystemSoundID = 0
        let soundPath = Bundle.main.path(forResource: "prompt", ofType: "wav")
        let baseURL = URL(fileURLWithPath: soundPath!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL as CFURL, &soundID)
        //播放通知声音
        AudioServicesPlaySystemSound(soundID)
    })
}


// MARK:- 自定义打印
func OFOLog<T>(_ message: T,
           file: String = #file,
           method: String = #function,
           line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}


