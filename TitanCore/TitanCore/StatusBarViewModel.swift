//
//  StatusBarViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/25/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyPostgreSQL
import RxCocoa

public protocol StatusBarViewModelType {
    var input: StatusBarViewModelInput {get}
    var output: StatusBarViewModelOutput {get}
}

public protocol StatusBarViewModelInput {
    var queryResultPublisher: PublishSubject<QueryResult> {get}
    var selectionRowPublisher: PublishSubject<IndexSet> {get}
}

public protocol StatusBarViewModelOutput {
    var statusDriver: Driver<String>! {get}
}

//
// MARK: - StatusBarViewModel
open class StatusBarViewModel: BaseViewModel, StatusBarViewModelType, StatusBarViewModelInput, StatusBarViewModelOutput {
    
    //
    // MARK: - Type
    public var input: StatusBarViewModelInput {return self}
    public var output: StatusBarViewModelOutput {return self}
    
    //
    // MARK: - Input
    public var queryResultPublisher = PublishSubject<QueryResult>()
    public var selectionRowPublisher = PublishSubject<IndexSet>()
    
    //
    // MARK: - Output
    public var statusDriver: Driver<String>!
    
    //
    // MARK: - Init
    override public init() {
        super.init()
        
        self.binding()
    }
    
    fileprivate func binding() {
        
        // Update statu bar
        self.statusDriver = self.queryResultPublisher.asObserver().map { (queryResult) -> String in
            
            let count = queryResult.rowsAffected
            
            if count <= 0 {
                return "0 Rows"
            }
            
            return "Rows \(count)"
        }
        .asDriver(onErrorJustReturn: "0 Rows")

        // Selection change
        self.selectionRowPublisher.filter { (indexSet) -> Bool in
            return indexSet.count > 0
        }
        .map { (indexSet) -> String in
            
        }
    }
}
