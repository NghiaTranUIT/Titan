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
    var databaseDataPublisher: PublishSubject<DatabaseData> {get}
}

public protocol ConnectionDetailViewModelOutput {
    
    // Selected database
    var selectedDatabaseVariable: Variable<DatabaseObj?> { get }
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
    public var databaseDataPublisher = PublishSubject<DatabaseData>()
    
    //
    // MARK: - Output
    public var selectedDatabaseVariable: Variable<DatabaseObj?> {return self._selectedDatabaseVariable}
    
    //
    // MARK: - Variable
    fileprivate var _selectedDatabaseVariable: Variable<DatabaseObj?>!
    
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
        self._selectedDatabaseVariable = MainStore.globalStore.connectionStore
            .selectedDatabase
        

        // Connect selected database
        self.connectDatabasePublisher
        .do(onNext: { _ in
            let action = SaveTempDatabaseToCurrentDatabaseAction()
            MainStore.dispatch(action)
        })
        .flatMap {[unowned self] (_) -> Observable<Void> in
            return self.getConnectDatabaseWorker()
        }
        .subscribe(onNext: { (_) in
            NotificationManager.postNotificationOnMainThreadType(.openDetailDatabaseWindow)
        }, onError: { (error) in
            Logger.error("Error connect DB \(error)")
        })
        .addDisposableTo(self.disposeBag)
        
        
        // Create temp data
        self.databaseDataPublisher
        .flatMap({ (data) -> Observable<DatabaseData> in
            return UpdateDatabaseTempWorker(tempData: data).observable()
        })
        .subscribe()
        .addDisposableTo(self.disposeBag)
    }
}

//
// MARK: - Worker
extension ConnectionDetailViewModel {
    fileprivate func getConnectDatabaseWorker() -> Observable<Void> {
        let databaseObj = MainStore.globalStore.connectionStore.selectedDatabase.value!
        let worker = ConnectDatabaseWorker(databaseObj: databaseObj)
        return worker.observable()
    }
}
