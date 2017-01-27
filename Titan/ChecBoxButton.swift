//
//  ChecBoxButton.swift
//  Titan
//
//  Created by Nghia Tran on 1/15/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class CheckBoxButton: NSButton {

    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    
    //
    // MARK: - Public
    func initDefaultCheckBox(with title: String) {
        
        // Image
        self.image = NSImage(named: "icon_checkbox")
        self.alternateImage = NSImage(named: "icon_checkbox_selected")
        
        // Title
        self.title = title
        self.alternateTitle = title
    }
}
