//
//  ScanViewController.swift
//  OFO_Development
//
//  Created by brother on 2017/8/16.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import swiftScan

class ScanViewController: LBXScanViewController {

    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash: Bool = false
    
    @IBOutlet weak var panelView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫码用车"
        
        initializeUI()
    }
    
    func initializeUI() {
        
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = #imageLiteral(resourceName: "bg_QRCodeLine_244x3")
        
        scanStyle = style
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// 防止被掩盖
        view.bringSubview(toFront: panelView)
    }
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        for result:LBXScanResult in arrayResult
        {
            if let str = result.strScanned {
                print(str)
            }
        }
        
        let result:LBXScanResult = arrayResult[0]
        
        let web = BasicWebViewController()
        web.webURL = result.strScanned
        web.webName = "注册"
        navigationController?.pushViewController(web, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScanViewController {
    
    @IBAction func inputClick(button: UIButton) {
        print("手动输入编码")
        
        let inputCode = InputCodeViewController()
        navigationController?.pushViewController(inputCode, animated: true)
    }
    
    @IBAction func lightClick(button: UIButton) {
        button.isSelected = !button.isSelected
        
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash
        {
            print("打开手电筒")
        }
        else
        {
            print("关闭手电筒")
        }
    }
}

