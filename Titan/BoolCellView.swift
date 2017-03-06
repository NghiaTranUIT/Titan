//
//  BoolCellView.swift
//  Titan
//
//  Created by Nghia Tran on 3/6/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

class BoolCellView: BaseTableCellView {

    //
    // MARK: - OUTLEt
    fileprivate var checkboxBtn: NSButton!
    
    //
    // MARK: - Init
    required init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // Setup layout
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Setup layout
        self.setupLayout()
    }
    
    //
    // MARK: - Public
    func configureCell() {
        
    }
    
}

//
// MARK: - Private
extension BoolCellView {
    
    fileprivate func setupLayout() {
        
        // Checkbox
        self.checkboxBtn = NSButton(frame: NSRect.zero)
        self.checkboxBtn.translatesAutoresizingMaskIntoConstraints = false
        self.checkboxBtn.title = ""
        self.checkboxBtn.setButtonType(NSButtonType.switch)
        self.addSubview(self.checkboxBtn)
        self.checkboxBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(NSEdgeInsetsZero)
        }
    }
}
