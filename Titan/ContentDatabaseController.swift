//
//  DataListController.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import SnapKit

protocol ContentDatabaseControllerOutput {
    
}

class ContentDatabaseController: NSViewController {

    //
    // MARK: - Variable
    fileprivate var tableStackView: TableStackView!
    fileprivate var gridDatabaseViews: [GridDatabaseView] = []
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var stackContainerView: NSView!
    @IBOutlet weak var contentContainerView: NSView!
    
    //
    // MARK: - Variable
    var output: ContentDatabaseControllerOutput?
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContentDatabaseConfig.shared.configure(viewController: self)
        
        // Init
        self.initStackView()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    override func initObserver() {
        NotificationManager.observeNotificationType(NotificationType.selectedTableStateChanged, observer: self, selector: #selector(self.selectedTableStateChangedNotification), object: nil)
        NotificationManager.observeNotificationType(.stackTableStateChanged, observer: self, selector: #selector(self.stackTableStateChangedNotification), object: nil)
    }
    
    @objc func selectedTableStateChangedNotification() {
        
    }
    
    @objc func stackTableStateChangedNotification() {
        
        // Update stack view
        self.tableStackView.updateStackView()
    }
}

extension ContentDatabaseController: ContentDatabasePresenterOutput {
    
}

//
// MARK: - Private
extension ContentDatabaseController {
    
    fileprivate func initStackView() {
        var topViews: NSArray? = nil
        let outputPtr = AutoreleasingUnsafeMutablePointer<NSArray>(&topViews)
        let _ = TableStackView.xib()!.instantiate(withOwner: self, topLevelObjects: outputPtr)
        
        // Init
        self.tableStackView = topViews?.lastObject! as! TableStackView
        
        // Add subview
        self.stackContainerView.addSubview(self.tableStackView)
        self.tableStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.stackContainerView).inset(NSEdgeInsetsZero)
        }
    }
    
    fileprivate func initContentDatabase() {
        
    }
}
