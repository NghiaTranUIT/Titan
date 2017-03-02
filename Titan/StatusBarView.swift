//
//  StatusBarView.swift
//  Titan
//
//  Created by Nghia Tran on 3/2/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa
import SnapKit

class StatusBarView: NSView {
    
    //
    // MARK: - OUTLET
    
    @IBOutlet weak var statusLbl: NSTextField!
    @IBOutlet weak var pageNumberBtn: NSButton!
    @IBOutlet weak var nextPageBtn: NSButton!
    @IBOutlet weak var previousPageBtn: NSButton!
    @IBOutlet weak var addRowBtn: NSButton!
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Base
        self.initBaseAbility()
    }
    
    //
    // MARK: - Public
    func configureLayoutWithView(_ view: NSView) {
        guard self.superview == nil else {return}
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(NSEdgeInsetsZero)
        }
    }
    
    //
    // MARK: - Action
    @IBAction func pageNumberBtnTapped(_ sender: Any) {
    }
    
    @IBAction func nextPageBtnTapped(_ sender: Any) {
    }
    
    @IBAction func previousPageBtnTapped(_ sender: Any) {
    }
    
    @IBAction func addRowBtnTapped(_ sender: Any) {
    }
}

//
// MARK: - XIBInitializable
extension StatusBarView: XIBInitializable {
    typealias T = StatusBarView
}
