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

protocol ListConnectionViewModelDelegate: class {
    func ListConnectionViewModelShouldReload(sender: ListConnectionViewModel)
}

class ListConnectionViewModel: BaseViewModel {
    
    //
    // MARK: - Variable
    weak var delegate: ListConnectionViewModelDelegate?
    
    //
    // MARK: - Observable
    private var selectedConnection: Variable<DatabaseObj>!
    fileprivate var connections: Variable<[DatabaseObj]> = Variable<[DatabaseObj]>([])
    let textFieldInputObserver = Variable<String>("")
    
    //
    // MARK: - Public
    func fetchConnections() {
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
        self.connections.asObservable().observeOn(QueueManager.shared.mainQueue)
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
