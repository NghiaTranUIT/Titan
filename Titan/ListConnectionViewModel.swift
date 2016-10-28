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
    fileprivate var connections: Driver<[DatabaseObj]>!
    private var requestConnectionsObs: Driver<FetchListConnectionsRequest.Response>!
    let textFieldInputObserver = Variable<String>("")
    
    //
    // MARK: - Public
    func fetchConnections() {
            self.connections = FetchListConnectionsRequest().toDirver().map({ (response) -> Driver<[DatabaseObj]> in
                switch response {
                case .Success(let value):
                    retu
                    break
                }
            })
    }
    
    override func initBinding() {
        
        // Auto reload connection if it changed
        self.connections.asObservable().observeOn(QueueManager.shared.mainQueue).subscribe {[unowned self] (connections) in
            self.delegate?.ListConnectionViewModelShouldReload(sender: self)
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
