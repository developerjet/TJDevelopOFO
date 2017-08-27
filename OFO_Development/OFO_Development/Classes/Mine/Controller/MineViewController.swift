//
//  MineViewController.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/12.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

class MineViewController: XDBasicViewController, UIApplicationDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// 加载控制器时设置打开抽屉模式(因为在后面会关闭)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawer.openDrawerGestureModeMask = .all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的消息"
        self.view.backgroundColor = UIColor.purple
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
