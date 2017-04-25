//
//  ContentDatabaseController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore
import SnapKit

class ContentDatabaseController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var containerStackView: NSView!
    @IBOutlet weak var containerGridView: NSView!
    fileprivate var stackView: StackTableView!
    
    //
    // MARK: - Variable
    fileprivate var viewModel: ContentDatabaseViewModel!
    
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initDataSource()
        self.initViewModel()
        self.binding()
        self.initStackView()
    }
    
}

//
// MARK: - Private
extension ContentDatabaseController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() {
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ContentDatabaseViewModel()
    }
    
    fileprivate func binding() {
        
        // Reload
        self.viewModel.output.selectedGridTableChangedDriver.drive(onNext: {[weak self] gridView in
            guard let `self` = self else {return}
            
            // Add 
            guard let gridView = gridView else {return}
            self.containerGridView.addSubview(gridView)
            gridView.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.containerGridView)
            })
            
        }).addDisposableTo(self.disposeBase)
    }
    
    fileprivate func initStackView() {
        let stackView = StackTableView.viewFromNib(with: BundleType.core)!
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.containerStackView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.containerStackView)
        }
        self.stackView = stackView
    }
}
