//
//  SideTableViewCell.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/13.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

class SideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var slideName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCellUI(imageName: String?, name: String?) {

        guard (imageName != nil), (name != nil) else {
            
            return
        }
        
        iconView.image = UIImage.init(named: imageName!)
        slideName.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
