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
    @IBOutlet weak var containerButtonsView: NSView!
    @IBOutlet weak var containerGridView: NSView!
    @IBOutlet weak var rowsBtn: HoverButton!
    @IBOutlet weak var structureBtn: HoverButton!
    @IBOutlet weak var indexBtn: HoverButton!
    @IBOutlet weak var sqlQueryBtn: HoverButton!
    
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
    }
    
    @IBAction func rowBtnTapped(_ sender: HoverButton) {
        self.resetAllState()
        sender.state = NSOnState
    }
    
    @IBAction func structureBtnTapped(_ sender: HoverButton) {
        self.resetAllState()
        sender.state = NSOnState
    }
    
    @IBAction func indexBtnTapped(_ sender: HoverButton) {
        self.resetAllState()
        sender.state = NSOnState
    }
    
    @IBAction func sqlQueryBtnTapped(_ sender: HoverButton) {
        self.resetAllState()
        sender.state = NSOnState
    }

}

//
// MARK: - Private
extension ContentDatabaseController {
    
    fileprivate func initCommon() {
        self.containerButtonsView.backgroundColor = NSColor(hexString: "#70599b")
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
    
    fileprivate func resetAllState() {
        self.rowsBtn.state = NSOffState
        self.indexBtn.state = NSOffState
        self.structureBtn.state = NSOffState
        self.sqlQueryBtn.state = NSOffState
    }
}
