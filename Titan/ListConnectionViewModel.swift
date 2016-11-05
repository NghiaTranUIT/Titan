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
    var selectedIndexPath: Observable<IndexPath>!
    var selectedConnection: Observable<DatabaseObj?> {
        
        guard let _ = self.selectedIndexPath else {
            return Observable.just(nil)
        }
        
        return self.selectedIndexPath.map ({ indexPath -> DatabaseObj in
            return self.connections.value[indexPath.item]
        })
    }
    
    fileprivate var connections: Variable<[DatabaseObj]> = Variable<[DatabaseObj]>([])
    
    //
    // MARK: - Public
    func fetchConnections() {
        
        // Fetch List connections
        FetchListConnectionsRequest()
            .toAlamofireObservable()
            .observeOn(QueueManager.shared.backgroundQueue)
            .startWith(Result.Success([]))
            .map({ result -> [DatabaseObj] in
                switch result {
                case .Success(let data):
                    return data as! [DatabaseObj]
                case .Failure(_):
                    return []
                }})
            .shareReplay(1)
            .bindTo(self.connections)
            .addDisposableTo(self.disposeBag)
    }
    
    override func initBinding() {
        
        // Bind Connection -> Table View
        self.connections
            .asObservable()
            .observeOn(QueueManager.shared.mainQueue)
            .subscribe {[unowned self] (_) in
                Logger.info("Reload tableView")
                self.delegate?.ListConnectionViewModelShouldReload(sender: self)
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
