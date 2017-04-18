//
//  ConnectionDetailController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

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
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
