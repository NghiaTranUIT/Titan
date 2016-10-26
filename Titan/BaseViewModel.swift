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
    lazy var disposeBag: DisposeBag = {
       return DisposeBag()
    }()
    
    //
    // MARK: - Init
    init() {
        self.initBinding()
    }
    
    
    //
    // MARK: - Public
    func initBinding() {
        
    }
}
