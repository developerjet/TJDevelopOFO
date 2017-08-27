//
//  BasicWebViewController.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/12.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import MMDrawerController

class BasicWebViewController: XDBasicViewController {

    // MARK: - 定义属性
    var webURL: String?
    var webName: String?
    
    // MARK: - LazyLoad
    lazy var webView: UIWebView = {
        let web = UIWebView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        web.delegate = self
        web.backgroundColor = UIColor.mainHexColor()
        web.scalesPageToFit = true
        web.scrollView.bounces = true
        return web
    }()
    
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = webName
        
        loadWebRequest(urls: webURL)
        self.view.addSubview(webView)
        closePan()
        
        XDHUD.FTShowProgress("正在拼命加载...")
    }
    
    func closePan() {
        
        appDelegate.drawer.closeDrawerGestureModeMask = .all
    }
    
    func loadWebRequest(urls: String?) {
    
        guard urls != nil, ((urls?.characters.count)! > 0) else {
            return
        }
        
        self.webView.loadRequest(URLRequest.init(url: URL.init(string: urls!)!))
    }
}

extension BasicWebViewController: UIWebViewDelegate {
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        XDHUD.FTDissmiss()
        
        OFOLog("加载成功")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        XDHUD.FTDissmiss()
        
        OFOLog("加载失败")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let requestURL: String = (request.url?.absoluteString)!
    
        if requestURL.characters.count <= 0 {
            
            return false
        }
        
        return true
    }
}
