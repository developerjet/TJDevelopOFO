//
//  XDBasicViewController.swift
//  OnlyBotherSwift_Seller
//
//  Created by CoderTan on 2017/2/14.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

class XDBasicViewController: UIViewController {

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        self.view.endEditing(true)
//        XDHUD.hide()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.mainHexColor()
        
//        HUD.dimsBackground = false
//        HUD.allowsInteraction = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //收键盘
        self.view.endEditing(true)
    }
}
