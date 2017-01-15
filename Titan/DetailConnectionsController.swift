//
//  DetailConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift

protocol DetailConnectionsControllerOutput {
    func connectConnection(_ connection: DatabaseObj)
}

protocol DetailConnectionsControllerDataSource: class {
    var selectedDatabase: DatabaseObj {get}
}

class DetailConnectionsController: NSViewController {

    //
    // MARK: - Outlet
    @IBOutlet weak var hostNameTxt: NSTextField!
    @IBOutlet weak var usernameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSTextField!
    @IBOutlet weak var databaseTxt: NSTextField!
    @IBOutlet weak var userSSHCheckBox: NSButton!
    @IBOutlet weak var portTxt: NSTextField!
    @IBOutlet weak var connectBtn: NSButton!
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
    
    override func initCommon() {
        
        /// IBAction
        //self.connectBtn.target = self
        //self.connectBtn.action = #selector(DetailConnectionsController.connectConnectionTapped)
    }
    
    override func initUIs() {
        
        // Top bar Background
        self.topBarView.backgroundColor = NSColor(hexString: "1799DD")
    }
    
    override func initActions() {
        
        /// Config
        DetailConnectionConfig.shared.configure(viewController: self)
    }
    
    
    //
    // MARK: - IBAction
    @objc fileprivate func connectConnectionTapped() {
        self.output.connectConnection(self.dataSource.selectedDatabase)
    }
}

//
// MARK: - DetailConnectionPresenterOutput
extension DetailConnectionsController: DetailConnectionPresenterOutput {
    func presentError(with error: NSError) {
        
    }
}
