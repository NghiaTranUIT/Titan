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
    
    
    //
    // MARK: - Rx
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func setupBinding() {
        self.userSSHCheckBox.rx.tap.subscribe { (_) in
            Logger.info("TApped")
        }.addDisposableTo(self.disposeBag)
    }
}
