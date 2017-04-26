//
//  PlaceholderCell.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

class PlaceholderCell: NSTableCellView {

    //
    // MARK: - OUTLET
    @IBOutlet weak var placeholderTitleLbl: NSTextField!
    @IBOutlet weak var loaderView: NSProgressIndicator!
    
    //
    // MARK: - View Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Prepare
        self.loaderView.stopAnimation(nil)
    }
    
    func configurePlaceholderCell(with title: String, isShowLoader: Bool) {
        
        // Loader
        if isShowLoader {
            self.loaderView.isHidden = false
            self.placeholderTitleLbl.isHidden = true
            self.loaderView.startAnimation(nil)
        }
        else {
            self.loaderView.isHidden = true
            self.placeholderTitleLbl.isHidden = false
            self.loaderView.stopAnimation(nil)
        }
        
        // Title
        self.placeholderTitleLbl.stringValue = title
    }
    
}
