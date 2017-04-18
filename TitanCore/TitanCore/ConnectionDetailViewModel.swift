//
//  ConnectionDetailViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift

//
// MARK: - Protocol
public protocol ConnectionDetailViewModelType {
    var input: ConnectionDetailViewModelInput { get }
    var output: ConnectionDetailViewModelOutput { get }
}

public protocol ConnectionDetailViewModelInput {
    var connectDatabasePublisher: PublishSubject<Void> { get }
}

public protocol ConnectionDetailViewModelOutput {
    
    // Selected database
    var selectedDatabaseObserver: Observable<DatabaseObj?> { get }
}

//
// MARK: - View Model
open class ConnectionDetailViewModel: BaseViewModel, ConnectionDetailViewModelType, ConnectionDetailViewModelInput, ConnectionDetailViewModelOutput {
    
    //
    // MARK: - Type
    public var input: ConnectionDetailViewModelInput {return self}
    public var output: ConnectionDetailViewModelOutput {return self}
    
    //
    // MARK: - Input
    public var connectDatabasePublisher = PublishSubject<Void>()
    
    //
    // MARK: - Output
    public var selectedDatabaseObserver: Observable<DatabaseObj?> {return self._selectedDatabaseObserver}
    
    //
    // MARK: - Variable
    fileprivate var _selectedDatabaseObserver: Observable<DatabaseObj?>!
    
    //
    // MARK: - Init
    public override init() {
        super.init()
        
        // Binding
        self.binding()
    }
}

//
// MARK: - Private
extension ConnectionDetailViewModel {
    
    fileprivate func binding() {
        
        // Selected database
        self._selectedDatabaseObserver = MainStore.globalStore.connectionStore
            .selectedDatabase
            .asObservable()
        
        // Connect selected database
        
    }
}
