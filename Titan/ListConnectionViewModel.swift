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
    fileprivate var connections = Variable<[DatabaseObj]>([])
    private var requestConnectionsObs: Driver<FetchListConnectionsRequest.Response>!
    
    //
    // MARK: - Public
    func fetchConnections() {
            FetchListConnectionsRequest()
            .toDirver()
            .drive(onNext: { (response: FetchListConnectionsRequest.Response) in
                switch response {
                case .Failure(let error):
                    Logger.info("Error = \(error)")
                    break
                case .Success(let result):
                    Logger.info("Here = \(result)")
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
