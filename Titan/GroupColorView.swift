//
//  GroupColorView.swift
//  Titan
//
//  Created by Nghia Tran on 12/4/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa


//
// MARK: - GroupColorView
class GroupColorView: NSView {

    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func initCommon() {
        
    }
    
    /// Appearance
    override func initAppearance() {
        
        // Corner
        self.wantsLayer = true
        self.layer?.cornerRadius = self.bounds.size.height / 2
    }
    
    //
    // MARK: - Public
    
    /// Update color with group Color obj
    func configureWith(groupColorObj: GroupColorObj) {
        
        // Render color
        self.backgroundColor = groupColorObj.color
    }
    
}
