//
//  ConnectionListViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RealmSwift
import RxSwift
import RxCocoa

public protocol ConnectionListViewModelInput {
    var fetchAllDatabasePublisher: PublishSubject<Void> { get }
    var selectedDatabasePublisher: PublishSubject<IndexPath> { get }
    var createGroupDatabasePublisher: PublishSubject<Void> { get }
    var createDatabaseInGroupPublisher: PublishSubject<GroupConnectionObj> { get }
}

public protocol ConnectionListViewModelOutput {
    var isLoading: Driver<Bool> { get }
    var groupConnectionsVariable: Variable<List<GroupConnectionObj>> { get }
    var reloadDataDriver: Driver<Void> {get}
}

public protocol ConnectionListViewModelType {
    var input: ConnectionListViewModelInput { get }
    var output: ConnectionListViewModelOutput { get }
}


//
// MARK: - ConnectionListViewModel
open class ConnectionListViewModel: BaseViewModel, ConnectionListViewModelType, ConnectionListViewModelInput, ConnectionListViewModelOutput {

    //
    // MARK: - View Model Type
    public var output: ConnectionListViewModelOutput { return self }
    public var input: ConnectionListViewModelInput { return self }
    
    //
    // MARK: - Input
    public var fetchAllDatabasePublisher = PublishSubject<Void>()
    public var selectedDatabasePublisher = PublishSubject<IndexPath>()
    public var createGroupDatabasePublisher = PublishSubject<Void>()
    public var createDatabaseInGroupPublisher = PublishSubject<GroupConnectionObj>()
    
    //
    // MARK: - Outut
    fileprivate var _isLoading = ActivityIndicator()
    public var isLoading: Driver<Bool> { return self._isLoading.asDriver()}
    public var groupConnectionsVariable: Variable<List<GroupConnectionObj>> {
        return MainStore.globalStore.connectionStore.groupConnections
    }
    fileprivate var _reloadDataDriver: Driver<Void>!
    public var reloadDataDriver: Driver<Void> {return self._reloadDataDriver}
    
    //
    // MARK: - Init
    public override init() {
        super.init()
        
        // Binding
        self.initBinding()
    }
    
    fileprivate func initBinding() {
        
        // Fetch database
        self.isLoading
            .asObservable()
            .sample(self.fetchAllDatabasePublisher)
            .flatMap { _isLoading -> Observable<Void> in
                if _isLoading.hashValue == 0 {
                    return self.fetchDatabaseWorker()
                }
                return Observable.empty()
        }.subscribe()
        .addDisposableTo(self.disposeBag)
        
        
        // Create new Group
        let createGroupObserver = self.createGroupDatabasePublisher
        .flatMap { (_) -> Observable<Void> in
            return self.createDefaultGroupDatabaseWorker()
        }
        
        
        // Create new database into group
        let createDbObserver = self.createDatabaseInGroupPublisher
        .flatMap { (groupObj) -> Observable<Void> in
            return self.createNewDatabaseWorker(with: groupObj)
        }
        
        
        // Reload
        self._reloadDataDriver = Observable.merge([createGroupObserver, createDbObserver]).asDriver(onErrorJustReturn: ())
        
        
        // Selected
        self.selectedDatabasePublisher
        .map({ (indexPath) -> DatabaseObj? in
            let groupObj = self.item(at: indexPath.section)
            return groupObj.databases[indexPath.item]
        })
        .flatMap { (databaseObj) -> Observable<Void> in
            guard let databaseObj = databaseObj else {
                return Observable.empty()
            }
            return self.selectedDatabaseObjWorker(databaseObj)
        }
        .subscribe()
        .addDisposableTo(self.disposeBag)
        
    }
}

//
// MARK: - ViewModelAccessible
extension ConnectionListViewModel: ViewModelAccessible {
    
    public typealias Element = GroupConnectionObj
    
    public var count: Int {
        return self.groupConnectionsVariable.value.count
    }
    
    public func item(at index: Int) -> Element {
        return self.groupConnectionsVariable.value[index]
    }
    
    public subscript(index: Int) -> Element {
        return self.item(at: index)
    }
}

//
// MARK: - Private
extension ConnectionListViewModel {
    
    fileprivate func fetchDatabaseWorker() -> Observable<Void> {
        let worker = FetchAllGroupConnectionsWorker()
        return worker.observable().trackActivity(self._isLoading)
            .flatMap {[unowned self] (groups) -> Observable<Void> in
                
                // Create default
                if groups.count == 0 {
                    return self.createDefaultGroupDatabaseWorker()
                }
                
                // Have Group, but no database
                if groups.count == 1 && groups.first!.databases.count == 0 {
                    return self.createNewDatabaseWorker(with: groups.first!)
                }
                
                // If have group, have databases -> Select first database
                if groups.count >= 1 && groups.first!.databases.count > 0 {
                    return self.selectedDatabaseObjWorker(groups.first!.databases.first!)
                }
                
                return Observable.empty()
        }
    }
    
    fileprivate func createDefaultGroupDatabaseWorker() -> Observable<Void> {
    
        let worker = CreateNewDefaultGroupConnectionWorker()
        return worker
        .observable()
        .flatMap({ (group) -> Observable<Void> in
            return CreateNewDatabaseWorker(groupConnectionObj: group).observable()
            .map({ (_) -> Void in
                return
            })
        })
    }
    
    fileprivate func createNewDatabaseWorker(with groupObj: GroupConnectionObj) -> Observable<Void> {
        
        let worker = CreateNewDatabaseWorker(groupConnectionObj: groupObj)
        return worker
        .observable()
        .map({ _ -> Void in
            return
        })
    }
    
    fileprivate func selectedDatabaseObjWorker(_ databaseObj: DatabaseObj) -> Observable<Void> {
        let worker = SelectConnectionWorker(selectedDb: databaseObj)
        return worker.observable().map({ (_) -> Void in
            return
        })
    }
}
