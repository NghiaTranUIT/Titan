//
//  ConnectionDetailController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore
import RxSwift

class ConnectionDetailController: BaseViewController {

    //
    // MARK: - Outlet
    @IBOutlet weak var nicknameTxt: NSTextField!
    @IBOutlet weak var hostNameTxt: NSTextField!
    @IBOutlet weak var usernameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSTextField!
    @IBOutlet weak var databaseTxt: NSTextField!
    @IBOutlet weak var sshCheckboxBtn: NSButton!
    @IBOutlet weak var saveInKeyChainCheckBoxBtn: NSButton!
    @IBOutlet weak var connectionBtn: NSButton!
    
    //
    // MARK: - Variable
    fileprivate var viewModel: ConnectionDetailViewModel!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init
        self.initCommon()
        self.initViewModel()
        self.binding()
    }
    
    fileprivate func binding() {
        
        // Update layout if select database
        self.viewModel.output.selectedDatabaseVariable
        .asObservable()
        .subscribe(onNext: {[weak self] (databaseObj) in
            guard let `self` = self else {return}
            guard let databaseObj = databaseObj else {return}
            
            // Update layout
            self.updateLayout(with: databaseObj)
            
            // Save temp
            self.viewModel.input.databaseDataPublisher.onNext(self.generateDatabaseData())
        })
        .addDisposableTo(self.disposeBase)
        
        
        // Connect database
        self.connectionBtn.rx.tap
        .bind(to: self.viewModel.input.connectDatabasePublisher)
        .addDisposableTo(self.disposeBase)
        
        
        // Data
        let nickOb = self.nicknameTxt.rx.text.asObservable()
        let hostOb = self.hostNameTxt.rx.text.asObservable()
        let usernameOb = self.usernameTxt.rx.text.asObservable()
        let passwordOb = self.passwordTxt.rx.text.asObservable()
        let databaseOb = self.databaseTxt.rx.text.asObservable()
        
        // Save
        Observable.combineLatest([nickOb, hostOb, databaseOb, usernameOb, passwordOb])
        .map {[unowned self] texts -> DatabaseData in
            return self.generateDatabaseData()
        }
        .bind(to: self.viewModel.input.databaseDataPublisher)
        .addDisposableTo(self.disposeBase)
    }
}

//
// MARK: - Private
extension ConnectionDetailController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ConnectionDetailViewModel()
    }
    
    fileprivate func updateLayout(with databaseObj: DatabaseObj) {
        self.nicknameTxt.stringValue = databaseObj.name
        self.hostNameTxt.stringValue = databaseObj.host
        self.usernameTxt.stringValue = databaseObj.username
        self.passwordTxt.stringValue = databaseObj.password
        self.databaseTxt.stringValue = databaseObj.database
    }
    
    fileprivate func generateDatabaseData() -> DatabaseData {
        return DatabaseData(nickName: self.nicknameTxt.stringValue, hostName: self.hostNameTxt.stringValue, databaseName: self.databaseTxt.stringValue, username: self.usernameTxt.stringValue, password: self.passwordTxt.stringValue)
    }
}
