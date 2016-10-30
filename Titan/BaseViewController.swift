//
//  BaseViewController.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift

class BaseViewController: NSViewController {

    //
    // MARK: - Variable
    let disposeBag = DisposeBag()
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        
        self.bindViewModel()
    }
    
    func initCommon() {
        // Do Nothing
    }
    
    func bindViewModel() {
        // Do nothing
    }
}
