//
//  Disposable.swift
//  Titan
//
//  Created by Nghia Tran on 10/29/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RxSwift

//
// MARK: - Base Disable for all element in Titan app
protocol DisposableBase {
    
    var DisposeBagKey: String {get}
    
    var disposeBag: DisposeBag? {get set}
}
