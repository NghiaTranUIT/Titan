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

class BaseViewModel: RxViewModel {
    
    //
    // MARK: - Variable
    
    
    //
    // MARK: - Init
    override init() {
        super.init()
        self.didBecomeActive.subscribe {[unowned self] (_) in
            self.initBinding()
        }.addDisposableTo(self.disposeBag)
    }
    
    //
    // MARK: - Public
    func initBinding() {
        
    }
}
