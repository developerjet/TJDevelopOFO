//
//  UIViewExtension.swift
//  OFO_Development
//
//  Created by CodeTan on 2017/7/13.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            
            return self.layer.borderWidth
        }
        set {
            
            return self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        
        get {
            
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            
            return self.layer.cornerRadius
        }
        set {
            
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
}


@IBDesignable class MyPerviewLabel: UILabel {
    
}

