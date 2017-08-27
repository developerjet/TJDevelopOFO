//
//  CompleteViewController.swift
//  OFO_Development
//
//  Created by brother on 2017/8/18.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import SwiftTimer

class CompleteViewController: XDBasicViewController {

    var resultNum = String()
    var timer: Timer!
    var remindSeconds = 121
    var code = ""
    
    @IBOutlet weak var label1st: MyPerviewLabel!
    @IBOutlet weak var labe12nd: MyPerviewLabel!
    @IBOutlet weak var labe13rd: MyPerviewLabel!
    @IBOutlet weak var label4th: MyPerviewLabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var passArray: [String] = [] {
        /// 监听array数组中值的变化
        didSet {
            self.label1st.text = passArray[0]
            self.labe12nd.text = passArray[1]
            self.labe13rd.text = passArray[2]
            self.label4th.text = passArray[3]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "解锁成功"
        self.view.backgroundColor = UIColor.backGroundHexColor()
        
        setResultNumbers(String(format:"车牌号：%@的解锁码", resultNum as CVarArg))
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
    }
    
    func timerStart() {
    
        remindSeconds -= 1
        timerLabel.text = String(String(format:"%d秒后开始计时，请检查车辆", remindSeconds as CVarArg))
        
        if remindSeconds == 0 {
            timer.invalidate()
            timer.fire()
        }
    }
    
    func setResultNumbers(_ num: String) {
        
        resultLabel.text = num;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// 销毁定时器
    deinit {
        
        if let timers = timer {
            timers.invalidate()
            timers.fire()
        }
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
