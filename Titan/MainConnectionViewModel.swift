//
//  MainConnectionViewModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift

protocol MainConnectionViewModelDataSource: class {
    func GetListConnectionModel(sender: MainConnectionViewModel) -> ListConnectionViewModel
    func GetDetailConnectionModel(sender: MainConnectionViewModel) -> DetailConnectionViewModel
}

class MainConnectionViewModel: BaseViewModel {

    //
    // MARK: - Variable
    weak var dataSource: MainConnectionViewModelDataSource?
    var listConnectionModel: ListConnectionViewModel {get {return self.dataSource!.GetListConnectionModel(sender: self)}}
    var detailConnectionModel: DetailConnectionViewModel {get {return self.dataSource!.GetDetailConnectionModel(sender: self)}}
    
    
    //
    // MARK: - Private
    override func initBinding() {
        
    }
}
