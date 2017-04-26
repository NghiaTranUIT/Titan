//
//  AddTableStackCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/3/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class AddTableStackCell: NSCollectionViewItem {

    //
    // MARK: - OUTLET
    @IBOutlet weak var addBtn: NSButton!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        self.addBtn.isEnabled = false
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: NSCollectionViewLayoutAttributes) -> NSCollectionViewLayoutAttributes {
        let layout = super.preferredLayoutAttributesFitting(layoutAttributes)
        layout.size = NSSize(width: 44, height: 44)
        return layout
    }
}
