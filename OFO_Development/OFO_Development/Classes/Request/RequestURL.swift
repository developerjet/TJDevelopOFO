//
//  RequestURL.swift
//  OFO_Development
//
//  Created by CoderTan on 2017/8/23.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import Foundation

#if DEBUG

private let host = "http://120.77.175.123:8080"
    
#else

private let host = "https://www.xiongdikeji.com"
    
#endif

private let webService = "/OnlyBrotherWebServiceTwo/"


private func appending(_ url: String) -> String {
    
    return host + webService + url
}


// MARK:- ===================== 我的消息 =====================
let url_news = appending("message/pageDataMasseage")
