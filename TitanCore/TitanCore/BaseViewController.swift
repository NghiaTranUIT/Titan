//
//  BaseViewController.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift

open class BaseViewController: NSViewController {

    //
    // MARK: - Variable
    public let disposeBase = DisposeBag()
    
    //
    // MARK: - View Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
