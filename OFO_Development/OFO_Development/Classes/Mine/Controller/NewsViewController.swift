//
//  NewsViewController.swift
//  OFO_Development
//
//  Created by CoderTan on 2017/8/23.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import SwiftyJSON

private let Identifiers = "NewsCell"

class NewsViewController: XDBasicViewController {

    lazy var tableView: UITableView = {
    
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let table = UITableView.init(frame: frame, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.tableFooterView = UIView.init(frame: .zero)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        self.view.backgroundColor = UIColor.backGroundHexColor()
        
        view.addSubview(tableView);
        
        begingRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- Request
extension NewsViewController {
    
    func begingRequest() {
        
        let params = ["pageNo": 1,
                      "pageSize": 10]
        
        let kNewsURL = url_news;

        RequestManager.get(url: kNewsURL, params: params, success: { (response) in
            guard let respObj = JSON(response).dictionaryObject else {
                return
            }
            
            print("respObj：%@", respObj)

        }) { (error) in
            
            XDHUD.FTErrorShow("请求失败")
        }
    }
    
}


// MARK:- delegate && dataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Identifiers)
    
        if cell == nil {
            
            cell = UITableViewCell.init(style: .default, reuseIdentifier: Identifiers)
            cell?.selectionStyle = .none
            cell?.textLabel?.text = "消息" + indexPath.row.description
        }
        
        return cell!
    }
}



