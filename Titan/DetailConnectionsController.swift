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
    
    //
    // MARK: - Variable
    // View Model
    let viewModel = DetailConnectionViewModel()
    
    //
    // MARK: - Rx
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.viewModel.active = true
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        self.viewModel.active = false
    }
    
    override func setupBinding() {
        
        // SSH
        self.userSSHCheckBox.rx.tap.subscribe { (_) in
            Logger.info("Tap SSH")
        }.addDisposableTo(self.disposeBag)
        
        // Host Name
        (self.hostNameTxt.rx.text <-> self.viewModel.hostNameVar).addDisposableTo(self.disposeBag)
        (self.usernameTxt.rx.text <-> self.viewModel.usernameVar).addDisposableTo(self.disposeBag)
        (self.passwordTxt.rx.text <-> self.viewModel.passwordVar).addDisposableTo(self.disposeBag)
        (self.databaseTxt.rx.text <-> self.viewModel.databaseVar).addDisposableTo(self.disposeBag)
    }
}
