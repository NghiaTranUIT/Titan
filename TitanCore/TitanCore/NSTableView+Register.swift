//
//  NSTableView.swift
//  Titan
//
//  Created by Nghia Tran on 11/13/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - Register View
public extension NSTableView {
    
    /// Helper register view
    /// The View must conform Identifier protocol
    func registerView<T: Identifier>(_ viewType: T.Type) {
        self.register(viewType.xib(), forIdentifier: viewType.identifierView)
    }
}
