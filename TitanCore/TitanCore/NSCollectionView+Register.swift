//
//  NSCollectionView+Register.swift
//  Titan
//
//  Created by Nghia Tran on 12/2/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - Register View
public extension NSCollectionView {
    
    /// Helper register cell
    /// The View must conform Identifier protocol
    func registerCell<T: Identifier>(_ viewType: T.Type, bundle: BundleType = .app) {
        self.register(viewType.xib(with: bundle), forItemWithIdentifier: viewType.identifierView)
    }
    
    /// Register Supplementary
    func registerSupplementary<T: Identifier>(_ supplementaryType: T.Type, kind: String, bundle: BundleType = .app) {
        self.register(supplementaryType.xib(with: bundle), forSupplementaryViewOfKind: kind, withIdentifier: supplementaryType.identifierView)
    }
}
