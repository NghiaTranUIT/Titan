//
//  DetailConnectionViewModel.swiftr
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
        /*
        self.selectedConnection
            .observeOn(QueueManager.shared.mainQueue)
            .subscribe { db in
                // Bind to UIs
                Logger.info("Selected databaseObj = ", db)
            }.addDisposableTo(self.disposeBag)
 */
    }
}
