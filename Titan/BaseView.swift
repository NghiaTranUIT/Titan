//
//  BaseView.swift
//  Titan
//
//  Created by Nghia Tran on 12/8/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa


//
// MARK: - BaseView
class BaseView: NSView {

    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Common
        self.initCommon()
        
        // Appearance
        self.initAppearance()
    }
    
    
    /// Init common
    func initCommon() {
        
    }
    
    
    /// Setup appearance
    func initAppearance() {
        
    }
}
