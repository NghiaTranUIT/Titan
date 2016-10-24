//
//  ListConnectionDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

class ListConnectionViewModel: BaseViewModel {
    
    //
    // MARK: - Public
    func fetchConnections() {
        let request = FetchListConnectionsRequest()
        request.toDirver()
            .drive(onNext: { (response: FetchListConnectionsRequest.Response) in
            
                switch response {
                case .Failure(let error):
                    Logger.info("Error = \(error)")
                    break
                case .Success(let result):
                    Logger.info("Here = \(result)")
                    break
                }
                
                
            }, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(self.disposeBag)
    }
}

//
// MARK: - Private
extension ListConnectionViewModel {
    
}
