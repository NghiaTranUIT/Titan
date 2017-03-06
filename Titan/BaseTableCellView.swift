//
//  BaseTableCellView.swift
//  Titan
//
//  Created by Nghia Tran on 3/6/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class BaseTableCellView: NSTableCellView {
    
    //
    // MARK: - Inital
    required override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // Draw
        self.setupDrawPolicy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Draw
        self.setupDrawPolicy()
    }
    
    class func viewWithIdentifier(_ id: String) -> Self {
        let view = self.init(frame: NSRect.zero)
        view.identifier = id
        return view
    }
    
    override var intrinsicContentSize: NSSize {
        guard let textField = self.textField else {
            return super.intrinsicContentSize
        }
        
        // NSTextField's intrinsic width is always -1 for editable text fields. Temporarily disable editability so we can
        let editable = textField.isEditable
        textField.isEditable = false
        let size = textField.intrinsicContentSize
        textField.isEditable = editable
        
        return size
    }
}

//
// MARK: - Private
extension BaseTableCellView {
    
    fileprivate func setupDrawPolicy() {
        self.canDrawSubviewsIntoLayer = true
        self.layerContentsRedrawPolicy = .duringViewResize
    }
}
