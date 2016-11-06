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
    
    // Use SSH
    @IBOutlet weak var userSSHCheckBox: NSButton!
    
    // Host Name
    @IBOutlet weak var hostNameTxt: NSTextField!
    
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
    
    override func setupBinding() {
        
        // SSH
        self.userSSHCheckBox.rx.tap.subscribe { (_) in
            Logger.info("Tap SSH")
        }.addDisposableTo(self.disposeBag)
        
        // Host Name
        self.hostNameTxt.rx.text.bindTo(self.viewModel.hostNameVar).addDisposableTo(self.disposeBag)
    }
}
