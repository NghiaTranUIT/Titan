//
//  DetailConnectionViewModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/24/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RxSwift

class DetailConnectionViewModel: BaseViewModel {

    //
    // MARK: - Rx
    var selectedConnection: Observable<DatabaseObj?>!
    var hostNameVar = Variable<String>("")
    
    //
    // MARK: - Private
    override func initBinding() {
        
        // Load data
        self.selectedConnection.observeOn(QueueManager.shared.mainQueue)
        .subscribe { (databaseObj) in
            // Bind to UIs
        }
        .addDisposableTo(self.disposeBag)
    }
}
