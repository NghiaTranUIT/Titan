//
//  ReduxStore.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

public protocol ReduxStore {

    // Store type
    var storyType: StoreType { get }
    
    // handle action
    func handleAction(_ action: Action)
}
