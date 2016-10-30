//
//  ListConnectionDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

protocol ListConnectionViewModelDelegate: class {
    func ListConnectionViewModelShouldReload(sender: ListConnectionViewModel)
}

class ListConnectionViewModel: BaseViewModel {
    
    //
    // MARK: - Variable
    weak var delegate: ListConnectionViewModelDelegate?
    
    //
    // MARK: - Observable
    private var selectedConnection: Variable<DatabaseObj?> = Variable<DatabaseObj?>(nil)
    var selectedIndexPath: Observable<IndexPath>! {
        didSet {
            self.bindSelectedConnection()
        }
    }
    fileprivate var connections: Variable<[DatabaseObj]> = Variable<[DatabaseObj]>([])
    let textFieldInputObserver = Variable<String>("")
    
    //
    // MARK: - Public
    func fetchConnections() {
        Logger.info("fetchConnections")
        Observable.just(1).flatMapLatest { (_) -> Observable<[DatabaseObj]> in
            return FetchListConnectionsRequest()
                .toAlamofireObservable()
                .startWith(Result.Success([]))
                .map({ result in
                    switch result {
                    case .Success(let data):
                        return data as! [DatabaseObj]
                    case .Failure(_):
                        return []
                    }
            })
        }
        .shareReplay(1)
        .bindTo(self.connections)
        .addDisposableTo(self.disposeBag)
    }
    
    override func initBinding() {
        
        // Bind Connection -> Table View
        self.connections.asObservable().observeOn(QueueManager.shared.mainQueue)
            .subscribe {[unowned self] (_) in
                Logger.info("Reload tableView")
                self.delegate?.ListConnectionViewModelShouldReload(sender: self)
            }.addDisposableTo(self.disposeBag)
        
        // Bind Table View selected
        self.selectedConnection.asObservable().observeOn(QueueManager.shared.mainQueue)
            .filterNil()
            .subscribe { (databaseObj) in
                Logger.info("Selected database = \(databaseObj.element)")
            }
            .addDisposableTo(self.disposeBag)
    }
    
    private func bindSelectedConnection() {
        // Bind selectedIndexPath -> SelectedConnection
        self.selectedIndexPath
            .map { (indexPath) -> DatabaseObj in
                let db = self.connections.value[(indexPath.item)]
                return db
            }
            .observeOn(QueueManager.shared.mainQueue)
            .subscribe { (database) in
                Logger.info("Selected database = \(database)")
            }.addDisposableTo(self.disposeBag)
    }
}

//
// MARK: - TableView
extension ListConnectionViewModel {
    func numberOfConnection() -> Int {
        return self.connections.value.count
    }
    
    func connection(atRow row: Int) -> DatabaseObj {
        return self.connections.value[row]
    }
}


//
// MARK: - Private
extension ListConnectionViewModel {
    
}
