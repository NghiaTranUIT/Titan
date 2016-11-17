//
//  DetailConnectionsViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class DetailConnectionsController: BaseViewController {

    //
    // MARK: - Outlet
    @IBOutlet weak var hostNameTxt: NSTextField!
    @IBOutlet weak var usernameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSTextField!
    @IBOutlet weak var databaseTxt: NSTextField!
    @IBOutlet weak var userSSHCheckBox: NSButton!
    @IBOutlet weak var portTxt: NSTextField!
    
    //
    // MARK: - Variable
    
    //
    // MARK: - Rx
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
