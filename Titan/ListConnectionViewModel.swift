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

class ListConnectionViewModel: BaseViewModel {
    
    //
    // MARK: - Observable
    var selectedConnection: Variable<DatabaseObj>!
    var requestConnectionsObs: Driver<FetchListConnectionsRequest.Response>!
    
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
        .addDisposableTo(self.disposeBag)
    }
}

//
// MARK: - Private
extension ListConnectionViewModel {
    
}
