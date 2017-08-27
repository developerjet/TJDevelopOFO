//
//  NetworkHelper.swift
//  OFO_Development
//
//  Created by brother on 2017/8/22.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import Foundation
import AVOSCloud

struct NetworkHelper {
    
}

extension NetworkHelper {
    
    static func getPass(code: String, completion: @escaping (String?) ->()) {
        
        let query = AVQuery(className: "OFOCode")
        
        query.whereKey("code", equalTo: code)
        
        /// 只查询一条
        query.getFirstObjectInBackground { (code, error) in
            
            guard error == nil else {
                XDHUD.FTErrorShow("无此车牌号")
                return;
            }

            if let code = code, let pass = code["pass"] as? String {
                
                completion(pass)
            }
        }
    }
}
