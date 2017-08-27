//
//  SideHeadView.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/13.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit
import Kingfisher


class SideHeadView: UIView {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconView.layer.cornerRadius = iconView.layer.frame.size.height * 0.5;
        iconView.layer.masksToBounds = true
        
        let url = URL(string: "http://p3.music.126.net/cm1Zl1iA4FWPOeFciGJhxQ==/7834020348056256.jpg")
        iconView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "UserInfo_defaultIcon"), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)),KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
    }
    
    // MARK: - 加载Xib视图
    static func loadInstance() -> SideHeadView? {
    
        let nibView = Bundle.main.loadNibNamed("SideHeadView", owner: nil, options: nil)
        
        if let view = nibView?.first as? SideHeadView, Bundle.main.path(forResource: "SideHeadView", ofType: "xib") == nil {
            
            return view
        }
        
        return nil
    }
}
