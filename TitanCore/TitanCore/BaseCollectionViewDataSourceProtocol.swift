//
//  BaseCollectionViewDataSourceProtocol.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import Cocoa

//
// MARK: - Collection View Data Source
public protocol BaseCollectionViewDataSourceProtocol: CommonDataSourceProtocol {

    /// Selected Cell
    func didSelectItem(at indexPaths: Set<IndexPath>)
}

//
// MARK: - Default extension
extension BaseCollectionViewDataSourceProtocol {
    
    /// Selected cell
    func didSelectItem(at indexPaths: Set<IndexPath>) {
        // Do nothing
    }
}
