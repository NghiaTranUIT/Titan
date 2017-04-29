
//
//  GridDatabaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/21/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL
import RxSwift

//
// MARK: - Type
public protocol GridDatabaseViewModelType {
    var input: GridDatabaseViewModelInput {get}
    var output: GridDatabaseViewModelOutput {get}
}

public protocol GridDatabaseViewModelInput {
    var statePublisher: PublishSubject<GridDatabaseViewModelState> {get}
}

public protocol GridDatabaseViewModelOutput {
    var stateVariable: Variable<GridDatabaseViewModelState> {get}
}

public enum GridDatabaseViewModelState {
    case row
    case structure
    case index
    case sqlQuery
}

//
// MARK: - GridDatabaseViewModel
open class GridDatabaseViewModel: BaseViewModel, GridDatabaseViewModelType, GridDatabaseViewModelOutput, GridDatabaseViewModelInput {
    
    //
    // MARK: - Type
    public var input: GridDatabaseViewModelInput {return self}
    public var output: GridDatabaseViewModelOutput {return self}
    
    //
    // MARK: - Input
    public var statePublisher = PublishSubject<GridDatabaseViewModelState>()
    
    //
    // MARK: - Output
    public var stateVariable = Variable<GridDatabaseViewModelState>(.row)
    
    //
    // MARK: - Init
    public override init() {
        super.init()
    
        self.binding()
    }
    
    deinit {
        Logger.info("GridDatabaseViewModel Deinit")
    }
    
    fileprivate func binding() {
        self.statePublisher.bind(to: self.stateVariable)
        .addDisposableTo(self.disposeBag)
    }
}
