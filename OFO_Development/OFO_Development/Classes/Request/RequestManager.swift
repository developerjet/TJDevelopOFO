//
//  RequestManager.swift
//  OFO_Development
//
//  Created by brother on 2017/8/22.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RequestManager {
    
    private static let shared: RequestManager = {
        
        var manager = RequestManager()
        /// 配置请求文件
        return manager
    }()

    //static let shared = RequestManager()
    private init() {}
    
    
    /// GET
    class func get(url: String,
                   params: [String : Any]? = nil,
                   success: @escaping (_: Any) ->(),
                   failure: @escaping (_ error: Error) ->()) {
        
        shared.request(url: url,
                       method: .get,
                       params: params,
                       success: success,
                       failure: failure)
    }
    
    /// POST
    class func post(url: String,
                   params: [String : Any]? = nil,
                   success: @escaping (_: Any) ->(),
                   failure: @escaping (_ error: Error) ->()) {
        
        shared.request(url: url,
                       method: .post,
                       params: params,
                       success: success,
                       failure: failure)
    }

    /// upload
    class func upload(url: String,
                      params: [String: String],
                      data: [Data],
                      success: @escaping (_ response: Any) ->(),
                      failure: @escaping (_ error: Error) ->()) {
        
        shared.requestUpload(url: url,
                             params: params,
                             data: data,
                             success: success,
                             failure: failure)
    }
}


extension RequestManager {
    
    /// 常规的请求
    func request(url: String,
                 method: HTTPMethod,
                 params: [String: Any]?,
                 success: @escaping (_ result: Any)->(),
                 failure: @escaping (_ error: Error)->()) {
    
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default).responseJSON { (response: DataResponse<Any>) in

            if let json = response.result.value {
                
                let result = JSON(json as! [String: Any])
                
                /// 请求异常处理
                if result["returnResult"].intValue != 200 {
                
                    XDHUD.FTErrorShow(result["returnDetail"].stringValue)
                    success(json)
                    return
                }
                
                /// token失效统一处理
                if result["returnResult"].intValue == 30004 {
                    
                    XDHUD.FTErrorShow(result["returnDetail"].stringValue)
                    success(json)
                    return
                }
                
                success(json)
                return
            }
            
            /// 请求失败
            if let fail = response.result.error {
                
                failure(fail)
                return;
            }
        }
    }
    
    
    /// 图片上传
    func requestUpload(url: String,
                       params: [String: String],
                       data: [Data],
                       success: @escaping(_ result: Any)->(),
                       failure: @escaping(_ error: Error) -> ()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        // 默认post请求
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //多张图片上传
            let flag = params["flag"]
            let userId = params["userId"]

            multipartFormData.append((flag?.data(using: String.Encoding.utf8))!, withName: "flag")
            multipartFormData.append((userId?.data(using: String.Encoding.utf8))!, withName: "userId")
            
            for i in 0..<data.count {
                //设置图片的名字
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let string = formatter.string(from: Date())
                let filename = "\(string).jpg"
                multipartFormData.append(data[i], withName: "img", fileName: filename, mimeType: "image/jpeg")
            }
        }, to: url, headers: headers, encodingCompletion:{ encodingResult in
            switch encodingResult{
            case .success(request: let upload,_,_):
                upload.responseJSON(completionHandler: { (response) in
                    if let json = response.result.value{
                        
                        let result = JSON(json as! [String: Any])
                        
                        if result["returnResult"].intValue != 200 {
                        
                            OFOLog("上传失败")
                            return;
                        }
                        
                        success(json)
                        return;
                    }
                })
                
            case .failure(let error):
                failure(error)
                return;
            }
        })
    }
    
}




