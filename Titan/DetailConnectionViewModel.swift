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
    var hostNameVar = Variable<String>("")
    var usernameVar = Variable<String>("")
    var passwordVar = Variable<String>("")
    var databaseVar = Variable<String>("")
    var portVar = Variable<String>("")
    
    /// Selected Connection from Store
    private let selectedConnection = mainStore.state.connectionState.selectedConnection.shareReplay(1)
    
    //
    // MARK: - Private
    override func initBinding() {

        // UI Binding
        self.bindingUI()
    }
    
    private func bindingUI() {
        
        // Host name
        self.selectedConnection.map {return $0.host}
        .bindTo(self.hostNameVar)
        .addDisposableTo(self.disposeBag)
        
        // User name
        self.selectedConnection.map {return $0.username}
            .bindTo(self.usernameVar)
            .addDisposableTo(self.disposeBag)
        
        // Password
        self.selectedConnection.map {return $0.password}
            .bindTo(self.passwordVar)
            .addDisposableTo(self.disposeBag)
        
        // Database
        self.selectedConnection.map {return $0.database}
            .bindTo(self.databaseVar)
            .addDisposableTo(self.disposeBag)
        
        // Port 
        self.selectedConnection.map {return String($0.port)}
        .bindTo(self.portVar)
        .addDisposableTo(self.disposeBag)
 
    }
}
