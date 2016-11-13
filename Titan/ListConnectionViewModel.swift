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
import ReSwift

protocol ListConnectionViewModelDelegate: class {
    func ListConnectionViewModelShouldReload(sender: ListConnectionViewModel)
}

class ListConnectionViewModel: BaseViewModel {
    
    //
    // MARK: - Variable
    weak var delegate: ListConnectionViewModelDelegate?
    
    //
    // MARK: - Observable
    var selectedIndexPath: Observable<IndexPath>!
    var selectedConnection: Observable<DatabaseObj> {
        
        guard let _ = self.selectedIndexPath else {
            return Observable.never()
        }
        
        return self.selectedIndexPath.map ({ indexPath -> DatabaseObj in
            return self.connections.value[indexPath.item]
        })
    }
    
    fileprivate var connections = mainStore.state.connectionState.connections
    var addNewConnection: Observable<DatabaseObj>!
    
    //
    // MARK: - Public
    func fetchConnections() {
        
        // Fetch List connections
        let action = GetAllConnectionsAction()
        mainStore.dispatch(action)
    }
    
    override func initBinding() {
        
        // Bind Connection -> Table View
        self.connections
            .asObservable()
            .observeOn(QueueManager.shared.mainQueue)
            .subscribe {[unowned self] (db) in
                Logger.info("Reload tableView")
                self.delegate?.ListConnectionViewModelShouldReload(sender: self)
            }.addDisposableTo(self.disposeBag)
        
        // Selected
        self.selectedConnection
            .observeOn(QueueManager.shared.mainQueue)
            .subscribe { db in
                let action = SelectedConnectionAction(selectedConnection: db.element!)
                mainStore.dispatch(action)
            }.addDisposableTo(self.disposeBag)
        
        // Add New default connection 
        self.addNewConnection.map { (_) -> DatabaseObj in
            return DatabaseObj.defaultDatabase()
        }
        .flatMap { (db) -> Observable<DatabaseObj> in
            return db.save()
        }
        .subscribe { (db) in
            // Selected
            let action = SelectedConnectionAction(selectedConnection: db.element!)
            mainStore.dispatch(action)
            
            // Add to List connection 
            let addAction = AddNewConnectionToListConnectionAction(newConnection: db.element!)
            mainStore.dispatch(addAction)
        }
        .addDisposableTo(self.disposeBag)
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
