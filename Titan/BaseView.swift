//
//  BaseView.swift
//  Titan
//
//  Created by Nghia Tran on 12/8/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

extension NSView {
    
    //
    // MARK: - View Cycle
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        // Common
        self.initCommon()
        
        // Appearance
        self.initAppearance()
    }
}

extension NSView: BaseViewAbility {
    
    func initCommon() {
        
    }
    
    func initAppearance() {
        
    }
}
