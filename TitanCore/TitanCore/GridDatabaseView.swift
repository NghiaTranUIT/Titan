//
//  GridDatabaseView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL
import RxSwift

open class GridDatabaseView: NSView {

    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: TitanTableView!
    @IBOutlet weak var containerStatusBarView: NSView!
    
    //
    // MARK: - Variable
    public var table: Table! {didSet{
        self.initViewModel()
        self.binding()
        }}
    fileprivate var viewModel: GridDatabaseViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    public class func viewNib(with table: Table) -> GridDatabaseView {
        let view = GridDatabaseView.viewFromNib()!
        view.table = table
        return view
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        //
        self.initCommon()
    }
}

//
// MARK: - Private
extension GridDatabaseView {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initViewModel() {
        self.viewModel = GridDatabaseViewModel(with: self.table)
    }
    
    class func viewFromNib() -> GridDatabaseView? {
        
        var topViews: NSArray = []
        let xib = NSNib(nibNamed: "GridDatabaseView", bundle: Bundle(identifier: "com.fe.nghiatran.TitanCore"))
        let _ = xib?.instantiate(withOwner: self, topLevelObjects: &topViews)
        
        for subView in topViews {
            if let innerView = subView as? GridDatabaseView {
                return innerView
            }
        }
        
        return nil
    }
    
    fileprivate func binding() {
        
        // Fetch default query
        self.viewModel.input.fetchDatabaseFromTablePublisher.onNext()
        
        // Reload if have new query Result
        self.viewModel.output.queryResult.asDriver().drive(onNext: { _ in
            self.tableView.reloadData()
        }).addDisposableTo(self.disposeBag)
        .addDisposableTo(self.dispo)
    }
}

//
// MARK: - Grid view
extension GridDatabaseView {
    
    fileprivate func setupDataForTableView() {
        
        // Setup new columns
        self.tableView.setupColumns(self.columns)
        
        // Enable save
        self.autosaveColumnsWidth()
    }
}
