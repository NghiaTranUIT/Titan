//
//  CommonDataSourceDelegate.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - Common Data source
public protocol CommonDataSourceProtocol: class {
    
    // REQUIRED
    // Number of item
    func CommonDataSourceNumberOfItem(at section: Int) -> Int
    
    // Number of section
    func CommonDataSourceNumberOfSection() -> Int
    
    // Item at index path
    func CommonDataSourceItem(at indexPath: IndexPath) -> BaseModel
}
