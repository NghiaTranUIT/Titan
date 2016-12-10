//
//  BaseView.swift
//  Titan
//
//  Created by Nghia Tran on 12/8/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa


//
// MARK: - Override awakeFromNib
/// We shouldn't create too many BaseView like what we did before.
/// It's redundancy if we create many BaseView, ex: BaseView, BaseCollectionViewCell, BaseTableViewCell, ...
/// Just conform BaseAbility
/// Less code - less bug
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


//
// MARK: - BaseAbility
extension NSView: BaseAbility {
    
    
    /// Do common things here
    func initCommon() {}
    
    
    /// Do UIs things here
    func initAppearance() {}
}
