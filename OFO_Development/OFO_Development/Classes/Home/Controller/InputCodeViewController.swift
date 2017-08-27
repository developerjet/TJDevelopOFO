//
//  InputCodeViewController.swift
//  OFO_Development
//
//  Created by brother on 2017/8/16.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

class InputCodeViewController: XDBasicViewController {

    @IBOutlet weak var inputTextFiled: UITextField!
    @IBOutlet weak var canButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "车辆解锁"
        self.view.backgroundColor = UIColor.backGroundHexColor()
        
        inputTextFiled.delegate = self;
        inputTextFiled.layer.borderWidth = 2
        inputTextFiled.layer.borderColor = UIColor.RGB(r: 247, g: 215, b: 80, a: 1).cgColor
    
        canButton.backgroundColor = UIColor.boardLineColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "扫描用车", style: .done, target: self, action: #selector(scanClick))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 扫码用车
    func scanClick() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 去骑行
    @IBAction func canRiding(_ sender: Any) {
        view.endEditing(true)
        
        guard (inputTextFiled.text?.characters.count)! >= 4 else {
            XDHUD.FTErrorShow("请输入正确的车牌号")
            return
        }
        
        let code = inputTextFiled.text!
        let complete = CompleteViewController()
        
        complete.code = code
        complete.resultNum = self.inputTextFiled.text!
        
        /// 可测试号码：1008，1117，2324
        NetworkHelper.getPass(code: code) { (pass) in
            
            if let pass = pass {
                
                complete.passArray = pass.characters.map {
                    
                    return $0.description
                }
                
            }else {
                
                XDHUD.FTErrorShow("无此车牌号")
                return
            }
        }
        
        navigationController?.pushViewController(complete, animated: true)
    }
}


// MARK: - UITextFieldDelegate

extension InputCodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.isEqual(inputTextFiled) && string.characters.count > 0) {
            if (inputTextFiled.text?.trimAll(textField.text!, rangeCount: 4))!{
                canButton.backgroundColor = UIColor.btnBackgroundColor()
                canButton.isUserInteractionEnabled = true
                return true
            }else {
                return false
            }
        }
        else if (textField.isEqual(inputTextFiled) && string.characters.count <= 0) {
            canButton.isUserInteractionEnabled = false
            canButton.backgroundColor = UIColor.boardLineColor()
        }
        
        return true
    }
}


