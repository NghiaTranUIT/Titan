//
//  TitanTableView.swift
//  Titan
//
//  Created by Nghia Tran on 2/5/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

protocol ContextMenuTableViewDelegate: class {
    
    // Provide custom Context Menu View
    func customContexMenuView(for event: NSEvent) -> NSMenu?
}

class TitanTableView: NSTableView {

    //
    // MARK: - Variable
    weak var contextMenuDelegate: ContextMenuTableViewDelegate?
    
    //
    // MARK: - View Cycle
    override func menu(for event: NSEvent) -> NSMenu? {
        
        // Provide custom context
        if let menu = self.contextMenuDelegate?.customContexMenuView(for: event) {
            return menu
        }
        
        return super.menu(for: event)
    }
}
