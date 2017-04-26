//
//  StatusBarView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/25/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift
import SwiftyPostgreSQL

class StatusBarView: NSView {

    //
    // MARK: - OUTLET
    @IBOutlet weak var statusLbl: NSTextField!
    @IBOutlet weak var pageNumberBtn: NSButton!
    @IBOutlet weak var nextPageBtn: NSButton!
    @IBOutlet weak var previousPageBtn: NSButton!
    @IBOutlet weak var addRowBtn: NSButton!
    
    //
    // MARK: - Variable
    public var queryResultPublisher = PublishSubject<QueryResult>()
    fileprivate var viewModel: StatusBarViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initViewModel()
        self.binding()
    }
}

//
// MARK: - Private
extension StatusBarView {
    
    fileprivate func initViewModel() {
        self.viewModel = StatusBarViewModel()
    }
    
    fileprivate func binding() {
        
        // Bind new query result
        self.queryResultPublisher.bind(to: self.viewModel.input.queryResultPublisher)
        .addDisposableTo(self.disposeBag)
        
        // Status
        self.viewModel.output.statusDriver.drive(self.statusLbl.rx.text).addDisposableTo(self.disposeBag)
    }
    
}
extension StatusBarView: XIBInitializable {
    public typealias T = StatusBarView
}
