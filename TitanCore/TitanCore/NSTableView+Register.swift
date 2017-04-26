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
    func registerView<T: Identifier>(_ viewType: T.Type, bundleType: BundleType = .app) {
        self.register(viewType.xib(with: bundleType), forIdentifier: viewType.identifierView)
    }
}
