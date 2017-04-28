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
    fileprivate var statusBarView: StatusBarView!
    @IBOutlet weak var rowsBtn: HoverButton!
    @IBOutlet weak var structureBtn: HoverButton!
    @IBOutlet weak var indexBtn: HoverButton!
    @IBOutlet weak var sqlQueryBtn: HoverButton!
    @IBOutlet weak var containerButtonsView: NSView!
    
    //
    // MARK: - Variable
    public var table: Table! {didSet{
        self.initViewModel()
        self.binding()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        }}
    fileprivate var viewModel: GridDatabaseViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    public class func viewNib(with table: Table) -> GridDatabaseView {
        let view = GridDatabaseView.viewFromNib(with: .core)!
        view.table = table
        return view
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        //
        self.initCommon()
        self.initStatusBarView()
    }
    
    deinit {
        Logger.info("GridDatabaseView Deinit")
    }
    
    @IBAction func rowBtnTapped(_ sender: HoverButton) {
        self.resetAllState(sender)
    }
    
    @IBAction func structureBtnTapped(_ sender: HoverButton) {
        self.resetAllState(sender)
    }
    
    @IBAction func indexBtnTapped(_ sender: HoverButton) {
        self.resetAllState(sender)
    }
    
    @IBAction func sqlQueryBtnTapped(_ sender: HoverButton) {
        self.resetAllState(sender)
    }
}

//
// MARK: - Private
extension GridDatabaseView {
    
    fileprivate func initCommon() {
        self.containerButtonsView.backgroundColor = NSColor(hexString: "#70599b")
        self.rowsBtn.state = NSOnState
    }
    
    fileprivate func initViewModel() {
        self.viewModel = GridDatabaseViewModel(with: self.table)
    }
    
    fileprivate func initStatusBarView() {
        self.statusBarView = StatusBarView.viewFromNib(with: .core)!
        self.statusBarView.translatesAutoresizingMaskIntoConstraints = false
        self.containerStatusBarView.addSubview(self.statusBarView)
        self.statusBarView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.containerStatusBarView)
        }
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
        
        // Tap
        self.rowsBtn.rx.tap.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.resetAllState(self.rowsBtn)
        }).addDisposableTo(self.disposeBag)
        
        self.structureBtn.rx.tap.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.resetAllState(self.structureBtn)
        }).addDisposableTo(self.disposeBag)
        
        self.indexBtn.rx.tap.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.resetAllState(self.indexBtn)
        }).addDisposableTo(self.disposeBag)
        
        self.sqlQueryBtn.rx.tap.asObservable().subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.resetAllState(self.sqlQueryBtn)
        }).addDisposableTo(self.disposeBag)
        
        // Change state
        self.viewModel.output.stateVariable.asDriver().drive(onNext: { (state) in
            
        })
        .addDisposableTo(self.disposeBag)
        
    }
    
    fileprivate func resetAllState(_ sender: HoverButton) {
        let btns = [self.rowsBtn, self.indexBtn, self.structureBtn, self.sqlQueryBtn].filter { (btn) -> Bool in
            return btn !== sender
        }
        
        for btn in btns {
            btn!.state = NSOffState
        }
        sender.state = NSOnState
    }
}

//
// MARK: - Grid view
extension GridDatabaseView {
    
    fileprivate func setupDataForTableView() {
        
        // Setup new columns
        self.tableView.prepareColumns(viewModel.queryResultVariable.value.columns)
    }
}

//
// MARK: - NSTableViewDataSource
extension GridDatabaseView: NSTableViewDataSource {
    
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
extension GridDatabaseView: NSTableViewDelegate {
    public func tableViewSelectionDidChange(_ notification: Notification) {
        
    }
}

extension GridDatabaseView: XIBInitializable {
    public typealias T = GridDatabaseView
}
