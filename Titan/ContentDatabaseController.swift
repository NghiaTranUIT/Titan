//
//  DataListController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol ContentDatabaseControllerOutput {
    
}

class ContentDatabaseController: NSViewController {

    //
    // MARK: - Variable
    var output: ContentDatabaseControllerOutput?
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    override func initCommon() {
        ContentDatabaseConfig.shared.configure(viewController: self)
    }
    
    override func initObserver() {
        NotificationManager.observeNotificationType(NotificationType.selectedTableStateChanged, observer: self, selector: #selector(self.selectedTableStateChangedNotification), object: nil)
    }
    
    @objc func selectedTableStateChangedNotification() {
        
    }
}

extension ContentDatabaseController: ContentDatabasePresenterOutput {
    
}
