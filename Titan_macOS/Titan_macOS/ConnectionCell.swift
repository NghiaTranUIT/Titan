//
//  ConnectionCell.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore
import RxSwift

class ConnectionCell: NSCollectionViewItem {

    //
    // MARK: - Variable
    var databaseObj: DatabaseObj?
    fileprivate var disposeBag: DisposeBag?
    
    //
    // MARK: - Outlet
    @IBOutlet weak var databaseIconImageView: NSImageView!
    @IBOutlet weak var titleLbl: NSTextField!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base
        self.view.backgroundColor = NSColor.red
    }
    
    //
    // MARK: - Public
    func configureCell(with databaseObj: DatabaseObj) {
        self.databaseObj = databaseObj
        self.setupData()
    }
    
    override var isSelected: Bool {
        didSet {
            self.setupSelectionState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = nil
    }
}

//
// MARK: - Private
extension ConnectionCell {
    
    // Setup
    fileprivate func setupData() {
        guard let databaseObj = self.databaseObj else {return}
        
        // Title
        self.disposeBag = DisposeBag()
        
        // Name
        databaseObj.rx.observeWeakly(String.self, "name")
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (text) in
            self.titleLbl.stringValue = text ?? ""
        }).addDisposableTo(self.disposeBag!)
        
        
        // Select state
        self.setupSelectionState()
    }
    
    fileprivate func setupSelectionState() {
        
        // Selected
        if self.isSelected {
            self.databaseIconImageView.image = NSImage(named: "icon_database_selected")
            self.view.backgroundColor = NSColor(hexString: "#F4F5F9")
            self.titleLbl.textColor = NSColor(hexString: "#606872")
            return
        }
        
        // Non-selected
        self.databaseIconImageView.image = NSImage(named: "icon_database")
        self.view.backgroundColor = NSColor.white
        self.titleLbl.textColor = NSColor(hexString: "#8D9298")
    }
}
