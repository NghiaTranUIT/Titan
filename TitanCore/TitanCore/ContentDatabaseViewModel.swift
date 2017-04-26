//
//  ContentDatabaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift
import RxBlocking
import RxCocoa
import SwiftyPostgreSQL

//
// MARK: - Type
public protocol ContentDatabaseViewModelType {
    var input: ContentDatabaseViewModelInput {get}
    var output: ContentDatabaseViewModelOutput {get}
}

public protocol ContentDatabaseViewModelInput {
    
}

public protocol ContentDatabaseViewModelOutput {
    var selectedGridTableChangedDriver: Driver<GridDatabaseView?>! {get}
    var gridDatabaseViewVariable: Variable<[GridDatabaseView]> {get}
}

//
// MARK: - ContentDatabaseViewModel
open class ContentDatabaseViewModel: BaseViewModel, ContentDatabaseViewModelType, ContentDatabaseViewModelInput, ContentDatabaseViewModelOutput {
    
    //
    // MARK: - Type
    public var input: ContentDatabaseViewModelInput {return self}
    public var output: ContentDatabaseViewModelOutput {return self}
    
    //
    // MARK: - Input
    
    //
    // MARK: - Output
    public var selectedGridTableChangedDriver: Driver<GridDatabaseView?>!
    public var gridDatabaseViewVariable: Variable<[GridDatabaseView]> {
        return MainStore.globalStore.detailDatabaseStore.gridDatabaseViews
    }
    
    //
    // MARK: - Init
    override public init() {
        super.init()
        
        self.binding()
    }
    
    fileprivate func binding() {
        
        // Fetch data from selected
        self.selectedGridTableChangedDriver = MainStore.globalStore.detailDatabaseStore.selectedGridDatabaseView.asDriver(onErrorJustReturn: nil)
    }
}
