//
//  DetailDatabaseContainerController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class DetailDatabaseContainerController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var stackViewContainer: NSView!
    
    //
    // MARK: - Variable
    fileprivate var stackView: StackTableView!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initStackView()
    }
}

//
// MARK: - Private
extension DetailDatabaseContainerController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initStackView() {
        let stackView = StackTableView.viewFromNib(with: .core)!
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewContainer.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.stackViewContainer)
        }
        self.stackView = stackView
    }
}
