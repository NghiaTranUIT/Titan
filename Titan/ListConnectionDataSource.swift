//
//  ListConnectionDataSource.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift

protocol ListConnectionDataSourceDelegate {
    func ListConnectionDataSourceChanged()
}

class ListConnectionDataSource: BaseDataSource {
    var delegate: ListConnectionDataSourceDelegate?
}
