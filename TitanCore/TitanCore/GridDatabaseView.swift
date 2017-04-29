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
    @IBOutlet weak var rowsBtn: DatabaseModeButton!
    @IBOutlet weak var structureBtn: DatabaseModeButton!
    @IBOutlet weak var indexBtn: DatabaseModeButton!
    @IBOutlet weak var sqlQueryBtn: DatabaseModeButton!
    @IBOutlet weak var containerButtonsView: NSView!
    @IBOutlet weak var containerView: NSView!
    
    //
    // MARK: - Variable
    public var table: Table! {
        didSet {
            self.initViewModel()
            self.binding()
        }
    }
    fileprivate var viewModel: GridDatabaseViewModel!
    fileprivate var disposeBag = DisposeBag()
    
    /// Subviews
    fileprivate var rowsView: RowsDatabaseView?
    fileprivate var structureView: StructureDatabaseView?
    fileprivate var indexView: IndexDatabaseView?
    fileprivate var sqlQueryView: SQLQueryDatabaseView?
    
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
    }
    
    deinit {
        Logger.info("GridDatabaseView Deinit")
    }
}

//
// MARK: - Private
extension GridDatabaseView {
    
    fileprivate func initCommon() {
        self.containerButtonsView.backgroundColor = NSColor(hexString: "#70599b")
        self.rowsBtn.state = NSOnState
        
        // Set state
        self.rowsBtn.databaseMode = .row
        self.indexBtn.databaseMode = .index
        self.structureBtn.databaseMode = .structure
        self.sqlQueryBtn.databaseMode = .sqlQuery
    }
    
    fileprivate func initViewModel() {
        self.viewModel = GridDatabaseViewModel()
    }
    
    fileprivate func binding() {
        
        //FIXME: Figure it out the best solution here
        
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
        self.viewModel.output.stateVariable.asDriver().drive(onNext: {[weak self] (state) in
            guard let `self` = self else {return}
            self.handleViewSate(state)
        })
        .addDisposableTo(self.disposeBag)
        
    }
    
    fileprivate func resetAllState(_ sender: DatabaseModeButton) {
        let btns = [self.rowsBtn, self.indexBtn, self.structureBtn, self.sqlQueryBtn].filter { (btn) -> Bool in
            return btn !== sender
        }
        
        for btn in btns {
            btn!.state = NSOffState
        }
        sender.state = NSOnState
        self.viewModel.input.statePublisher.onNext(sender.databaseMode)
    }
    
    fileprivate func handleViewSate(_ state: GridDatabaseViewModelState) {
        
        // Hide all
        self.hideAllView()
        
        // FIXME: Repeat code
        
        // Show
        switch state {
        case .row:
            if self.rowsView == nil {
                self.rowsView = self.lazyLoadView(viewType: RowsDatabaseView.self)
                self.rowsView!.table = self.table
            }
            self.rowsView?.isHidden = false
        
        case .index:
            if self.indexView == nil {
                self.indexView = self.lazyLoadView(viewType: IndexDatabaseView.self)
            }
            self.indexView?.isHidden = false
            
        case .sqlQuery:
            if self.sqlQueryView == nil {
                self.sqlQueryView = self.lazyLoadView(viewType: SQLQueryDatabaseView.self)
            }
            self.sqlQueryView?.isHidden = false
            
        case .structure:
            if self.structureView == nil {
                self.structureView = self.lazyLoadView(viewType: StructureDatabaseView.self)
            }
            self.structureView?.isHidden = false
        }
    }
    
    fileprivate func hideAllView() {
        
        let views: [NSView?] = [self.rowsView, self.indexView, self.structureView, self.sqlQueryBtn]
        for view in views {
            view?.isHidden = true
        }
    }
    
    fileprivate func lazyLoadView<T: NSView >(viewType: T.Type) -> T where T: XIBInitializable {
        let view = viewType.viewFromNib(with: .core) as! T
        view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.containerView)
        })
        return view
    }

}

extension GridDatabaseView: XIBInitializable {
    public typealias T = GridDatabaseView
}
