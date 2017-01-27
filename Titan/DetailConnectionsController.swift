//
//  DetailConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol DetailConnectionsControllerOutput {
    func connectConnection(_ connection: DatabaseObj)
}

protocol DetailConnectionsControllerDataSource: class {
    var selectedDatabase: DatabaseObj {get}
}

class DetailConnectionsController: NSViewController {

    
    //
    // MARK: - Outlet
    @IBOutlet weak var nicknameTxt: NSTextField!
    @IBOutlet weak var hostNameTxt: NSTextField!
    @IBOutlet weak var usernameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSTextField!
    @IBOutlet weak var databaseTxt: NSTextField!
    @IBOutlet weak var sshCheckboxBtn: NSButton!
    @IBOutlet weak var saveInKeyChainCheckBoxBtn: NSButton!
    @IBOutlet weak var topBarView: NSView!
    
    
    //
    // MARK: - Variable
    var output: DetailConnectionsControllerOutput!
    weak var dataSource: DetailConnectionsControllerDataSource!
    
    
    //
    // MARK: - Rx
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Base
        self.initBaseAbility()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    override func initCommon() {
        
    }
    
    override func initUIs() {
        
        // Top bar Background
        self.topBarView.backgroundColor = NSColor(hexString: "1799DD")
    }
    
    override func initActions() {
        
        /// Config
        DetailConnectionConfig.shared.configure(viewController: self)
    }
    
    override func initObserver() {
        NotificationManager.observeNotificationType(.prepareLayoutForSelectedDatabase, observer: self, selector: #selector(DetailConnectionsController.prepareLayoutNotification(noti:)), object: nil)
    }
    
    //
    // MARK: - IBAction
    
    @IBAction func sshCheckBoxBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func saveInKeyChainBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func connectConnectionTapped(_ sender: Any) {
        self.output.connectConnection(self.dataSource.selectedDatabase)
    }
    
    @objc fileprivate func prepareLayoutNotification(noti: Notification) {
        guard let databaseObj = noti.userInfo?["selectedDatabase"] as? DatabaseObj else {return}
        self.nicknameTxt.stringValue = databaseObj.name
        self.hostNameTxt.stringValue = databaseObj.host
        self.usernameTxt.stringValue = databaseObj.username
        self.passwordTxt.stringValue = databaseObj.password
        self.sshCheckboxBtn.state = databaseObj.ssh != nil ? NSOnState : NSOffState
        self.saveInKeyChainCheckBoxBtn.state = databaseObj.saveToKeychain ? NSOnState : NSOffState
        
    }
}

//
// MARK: - DetailConnectionPresenterOutput
extension DetailConnectionsController: DetailConnectionPresenterOutput {
    func presentError(with error: NSError) {
        
    }
}
