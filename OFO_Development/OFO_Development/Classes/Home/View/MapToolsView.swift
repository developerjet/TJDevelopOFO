//
//  MapToolsView.swift
//  OFO_Development
//
//  Created by brother on 2017/8/14.
//  Copyright © 2017年 CoderTan. All rights reserved.
//

import UIKit

/// 代理
protocol MapToolsProtocol: class {
    
    func toolsDidItemLocation()
    func toolsDidItemCase()
    func toolsDidItemScan()
}

class MapToolsView: UIView {

    @IBOutlet weak var caseBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var locaBtn: UIButton!
    
    @IBOutlet weak var backgroundView: UIImageView!
    weak var delegate: MapToolsProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        backgroundView.alpha = 0.1
        
        caseBtn.layer.cornerRadius = 20
        caseBtn.layer.masksToBounds = true
        
        locaBtn.tag = 1000
        caseBtn.tag = 1001
        scanBtn.tag = 1002
    }
    
    // MARK: - LoadFromNibXib
    static func loadToolsView() -> MapToolsView? {
        
        let nibView = Bundle.main.loadNibNamed("MapToolsView", owner: nil, options: nil)
        
        if let view = nibView?.first as? MapToolsView, Bundle.main.path(forResource: "MapToolsView", ofType: "xib") == nil {
            
            return view
        }
        
        return Bundle.main.loadNibNamed("MapToolsView", owner: self, options: nil)?.last as? MapToolsView
    }
}

extension MapToolsView {
    
    @IBAction func toolsClick(sender: UIButton) {
        
        let type: ToolsDidItemType = ToolsDidItemType(rawValue: UInt(sender.tag))!
        
        switch type {
        case .ToolsDidItemLocation:
            delegate?.toolsDidItemLocation()
        case .ToolsDidItemCase:
            delegate?.toolsDidItemCase()
        case .ToolsDidItemScan:
            delegate?.toolsDidItemScan()
        default:
            break
        }
        
    }
}

