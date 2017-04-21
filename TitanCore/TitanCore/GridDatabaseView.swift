//
//  GridDatabaseView.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import SwiftyPostgreSQL

open class GridDatabaseView: NSView {

    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: TitanTableView!
    @IBOutlet weak var containerStatusBarView: NSView!
    
    //
    // MARK: - Variable
    public var table: Table!
    fileprivate var viewModel: GridDatabaseViewModel!
    
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
        self.initViewModel()
    }
}

//
// MARK: - XIBInitializable
extension GridDatabaseView: XIBInitializable {
    public typealias T = GridDatabaseView
}

//
// MARK: - Private
extension GridDatabaseView {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initViewModel() {
        self.viewModel = GridDatabaseViewModel(with: self.table)
    }
}
