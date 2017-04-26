//
//  DatabaseValueCell.swift
//  Titan
//
//  Created by Nghia Tran on 2/12/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL
import SnapKit

open class TextFieldCellView: BaseTableCellView {

    //
    // MARK: - Init
    required public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        // Setup layout
        self.setupLayout()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Setup layout
        self.setupLayout()
    }
    
    override open func becomeFirstResponder() -> Bool {
        self.textField?.becomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    //
    // MARK: - Public
    public func configureCell(with field: Field, column: Column) {
        
        guard let textField = self.textField else {return}
        
        // Show raw data
        if field.isNull {
            textField.placeholderString = field.rawData
            textField.stringValue = ""
        } else {
            textField.stringValue = field.rawData
        }
        
        // Layout
        self.setupTextAlignment(with: column)
    }
}

//
// MARK: - Private
extension TextFieldCellView {
    
    fileprivate func setupLayout() {
        let textField = NSTextField(frame: NSRect.zero)
        textField.maximumNumberOfLines = 2
        textField.isBordered = false
        textField.drawsBackground = false
        textField.cell?.sendsActionOnEndEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.lineBreakMode = .byTruncatingTail
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(EdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
        }
        self.textField = textField
    }
    
    fileprivate func setupTextAlignment(with column: Column) {
        self.textField?.alignment = column.textAlignment
    }
}

