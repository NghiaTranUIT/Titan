//
//  DatabaseView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/28/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift
import SwiftyPostgreSQL

class RowsDatabaseView: NSView {
    
    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: TitanTableView!
    @IBOutlet weak var containerStatusBarView: NSView!
    fileprivate var statusBarView: StatusBarView!
    
    //
    // MARK: - Variable
    fileprivate var viewModel: RowDatabaseViewModel!
    fileprivate var disposeBag = DisposeBag()
    public var table: Table! {
        didSet {
            self.initViewModel()
            self.binding()
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    //
    // MARK: - View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}

//
// MARK: - Private
extension RowsDatabaseView {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initViewModel() {
        self.viewModel = RowDatabaseViewModel(with: self.table)
    }
    
    fileprivate func binding() {
        
        // Fetch default query
        self.viewModel.input.fetchDatabaseFromTablePublisher.onNext()
        
        // Reload if have new query Result
        self.viewModel.output.queryResultVariable.asDriver().drive(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            
            // Setup colums and data
            self.setupDataForTableView()
            
            // Reload
            self.tableView.reloadData()
        })
        .addDisposableTo(self.disposeBag)
        
        // Status bar
        self.viewModel.output.queryResultVariable.asObservable().subscribe(onNext: {[weak self] (queryResult) in
            guard let `self` = self else {return}
            
            // NOtify
            self.statusBarView.queryResultPublisher.onNext(queryResult)
        }).addDisposableTo(self.disposeBag)

    }
}

//
// MARK: - Grid view
extension RowsDatabaseView {
    
    fileprivate func setupDataForTableView() {
        
        // Setup new columns
        self.tableView.prepareColumns(viewModel.queryResultVariable.value.columns)
    }
}

//
// MARK: - NSTableViewDataSource
extension RowsDatabaseView: NSTableViewDataSource {
    
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return self.viewModel.queryResultVariable.value.rows.count
    }
    
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        guard let tableColumn = tableColumn as? TitanTableColumn else {return nil}
        
        let col = tableColumn.column!
        let field = self.viewModel.field(at: col, row: row)
        return field.rawData
    }
    
    public func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
        guard let cell = cell as? NSTextFieldCell else {return}
        guard let tableColumn = tableColumn as? TitanTableColumn else {return}
        
        let col = tableColumn.column!
        let field = self.viewModel.field(at: col, row: row)
        
        // Show raw data
        if field.isNull {
            cell.placeholderString = field.rawData
            cell.stringValue = ""
        } else {
            cell.stringValue = field.rawData
        }
    }
}

//
// MARK: - NSTableViewDelegate
extension RowsDatabaseView: NSTableViewDelegate {
    
}

extension RowsDatabaseView: XIBInitializable {
    typealias T = RowsDatabaseView
}
