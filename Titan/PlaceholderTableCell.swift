//
//  EmptyLoaderCollectionCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class PlaceholderTableCell: NSTableCellView {

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
