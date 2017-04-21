
//
//  GridDatabaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/21/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL

//
// MARK: - Type
public protocol GridDatabaseViewModelType {
    var input: GridDatabaseViewModelInput {get}
    var output: GridDatabaseViewModelOutput {get}
}

public protocol GridDatabaseViewModelInput {
    
}

public protocol GridDatabaseViewModelOutput {
    
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
    
    //
    // MARK: - Output
    
    //
    // MARK: - Variable
    fileprivate var table: Table!
    
    //
    // MARK: - Init
    public init(with table: Table) {
        super.init()
        
        self.table = table
    }
}
