//
//  BaseDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift

class BaseDataSource: NSObject {
    
    var store: Store<MainAppState>!
    
    convenience init(store: Store<MainAppState>) {
        self.init()
        self.store = store
        self.store.subscribe(self)
    }
    
    deinit {
        self.store.unsubscribe(self)
    }
}

extension BaseDataSource: StoreSubscriber {
    typealias StoreSubscriberStateType = MainAppState
    
    func newState(state: MainAppState) {
        
    }
}
