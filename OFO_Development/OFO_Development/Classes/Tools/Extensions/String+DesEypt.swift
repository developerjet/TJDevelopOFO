//
//  String+DesEypt.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/3/5.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import Foundation
import UIKit

private let encyptKey: String = "botherEncyptKey"


// MARK:- EncyptMethods
extension String {
    
    ///1.DES加密
    func desEncypt() -> String {
        
        let key = encyptKey
        var desKey: Data = key.data(using: String.Encoding.utf8)!
        
        var cipherText = String()
        let textData = self.data(using: String.Encoding.utf8)!
        let dataLength: Int = textData.count
        
        //let bufferSize: size_t = dataLength + kCCBlockSizeAES128
        
        
        return "DES"
    }
    
    
}
