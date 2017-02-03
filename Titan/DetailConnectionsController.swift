//
//  DetailConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol DetailConnectionsControllerOutput {
    func connectDatabase(_ databaseObj: DatabaseObj)
    func saveDatabaseObjToDisk(databaseObj: DatabaseObj, data: DetailConnectionData)
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
    @IBOutlet weak var connectionBtn: NSButton!
    
    //
    // MARK: - Variable
    var output: DetailConnectionsControllerOutput!
    var databaseObj: DatabaseObj!
    
    //
    // MARK: - Rx
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.initBaseAbility()
    }
    
    deinit {
        NotificationManager.removeAllObserve(self)
    }
    
    override func initCommon() {
        
        // Focus to Nickname
        self.nicknameTxt.becomeFirstResponder()
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
        NotificationManager.observeNotificationType(.prepareLayoutForSelectedDatabase, observer: self, selector: #selector(self.prepareLayoutNotification(noti:)), object: nil)
        NotificationManager.observeNotificationType(.saveCurrentDatabaseObj, observer: self, selector: #selector(self.saveCurrentDatabaseObjNotification(noti:)), object: nil)
    }
    
    //
    // MARK: - IBAction
    @IBAction func sshCheckBoxBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func saveInKeyChainBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func connectConnectionTapped(_ sender: Any) {
        // Save current first
        self.saveDatabase()
        
        // Connect
        self.output.connectDatabase(self.databaseObj)
    }
    
    @objc fileprivate func prepareLayoutNotification(noti: Notification) {
        guard let databaseObj = noti.userInfo?["selectedDatabase"] as? DatabaseObj else {return}
        self.databaseObj = databaseObj
        self.nicknameTxt.stringValue = databaseObj.name
        self.hostNameTxt.stringValue = databaseObj.host
        self.usernameTxt.stringValue = databaseObj.username
        self.passwordTxt.stringValue = databaseObj.password
        self.databaseTxt.stringValue = databaseObj.database
        self.sshCheckboxBtn.state = databaseObj.ssh != nil ? NSOnState : NSOffState
        self.saveInKeyChainCheckBoxBtn.state = databaseObj.saveToKeychain ? NSOnState : NSOffState
    }
    
    @objc fileprivate func saveCurrentDatabaseObjNotification(noti: Notification) {
        guard let obj = noti.object as? DatabaseObj else {return}
        guard obj.objectId == self.databaseObj.objectId else {return}
        
        // Save
        self.saveDatabase()
    }
    
    fileprivate func saveDatabase() {
        
        // Map all textfield to database
        let data = self.buildDetailConnectionData()
        
        // Save
        self.output.saveDatabaseObjToDisk(databaseObj: self.databaseObj, data: data)
    }
}

//
// MARK: - DetailConnectionPresenterOutput
extension DetailConnectionsController: DetailConnectionPresenterOutput {
    func presentError(with error: NSError) {
        
    }
}

//
// MARK: - Private
extension DetailConnectionsController {
    
    /// Map UI to model
    fileprivate func buildDetailConnectionData() -> DetailConnectionData {
        
        var data = DetailConnectionData()
        
        data.nickname = self.nicknameTxt.stringValue
        data.host = self.hostNameTxt.stringValue
        data.username = self.usernameTxt.stringValue
        data.password = self.passwordTxt.stringValue
        data.databaseName = self.databaseTxt.stringValue
        data.saveToKeyChain = self.saveInKeyChainCheckBoxBtn.state == NSOnState ? true : false
        
        // SSH
        if self.sshCheckboxBtn.state == NSOnState {
            let sshObj = SSHObj()
            sshObj.host = "localhost"
            sshObj.user = "nghiatran"
            data.sshObj = sshObj
        }
        
        return data
    }
}
