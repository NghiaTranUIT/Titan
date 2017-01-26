//
//  BaseModel+Store.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import PromiseKit

//
// MARK: - Store
protocol BaseModelStore {
    
    /// Save
    /// Save to Disk + Cloud
    func save() -> Promise<Void>
    
    /// Fetch
    func fetch() -> Promise<BaseModel?>
}
