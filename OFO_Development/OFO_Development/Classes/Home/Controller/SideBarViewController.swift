//
//  SideBarViewController.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/13.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

let Identifier = "SideCellIdentifier"

class SideBarViewController: XDBasicViewController {
    
    // MARK: - LazyLoad
    lazy var dataSource: NSArray = {
        let datas: NSArray =
                     [["image" : "icon_slide_trip", "name" : "我的行程"],
                     ["image" : "icon_slide_wallet", "name" : "我的钱包"],
                     ["image" : "icon_slide_invite", "name" : "邀请好友"],
                     ["image" : "icon_slide_coupon", "name" : "兑优惠券"],
                     ["image" : "icon_slide_myMsg", "name" : "我的消息"],
                     ["image" : "icon_slide_usage_guild", "name" : "我的客服"]]
        return datas
    }()
    
    lazy var footerView: UIView = {
        let footer = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 170))
        let backgroundView = UIImageView.init(frame: footer.bounds)
        backgroundView.image = UIImage.init(named: "confirm");
        footer.addSubview(backgroundView)
        return footer
    }()
    
    
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let table = UITableView.init(frame: frame)
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.register(UINib.init(nibName: "SideTableViewCell", bundle: nil), forCellReuseIdentifier: Identifier)
        return table
    }()
    
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initializeUI()
    }

    
    func initializeUI() {
        
        if let header = SideHeadView.loadInstance() {
            
            header.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 210)
            self.tableView.tableHeaderView = header
        }
        
        self.tableView.tableFooterView = footerView

        self.view.addSubview(self.tableView)
    }

}


extension SideBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - data && delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier) as! SideTableViewCell
        //cell.selectionStyle = .none
        
        if dataSource.count > indexPath.row {
            let images: [String] =  dataSource.value(forKey: "image") as! [String]
            let names: [String] = dataSource.value(forKey: "name") as! [String]
            cell.setCellUI(imageName: images[indexPath.row], name: names[indexPath.row])
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if dataSource.count > indexPath.row {
            
            if indexPath.row == 4 {
                
                let news = NewsViewController()

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let nav = appDelegate.drawer.centerViewController as! BasicNavigationController
                nav.pushViewController(news, animated: true)
                
                ///push成功时关闭抽屉
                appDelegate.drawer.closeDrawer(animated: true, completion: { (weak) in
                    // setOpenDrawerGestureModeMask
                    appDelegate.drawer.openDrawerGestureModeMask = .custom
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}
