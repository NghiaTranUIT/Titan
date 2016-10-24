//
//  BaseDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift

class BaseViewModel {
    
    //
    // MARK: - Variable
    var store: Store<MainAppState>!
    lazy var disposeBag = {return DisposeBag()}()
    
    //
    // MARK: - Init
    init() {
        self.store = mainStore
    }
}
