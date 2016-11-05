//
//  MainConnectionViewModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/26/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift

class MainConnectionViewModel: BaseViewModel {

    //
    // MARK: - Variable
    private let listConnectionModel = ListConnectionViewModel()
    private let connectionDetailModel = DetailConnectionViewModel()

    //
    // MARK: - Private
    override func initBinding() {
        
    }
}
