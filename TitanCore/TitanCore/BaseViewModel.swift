//
//  BaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift

//
// MARK: - ViewModelAccessible
public protocol ViewModelAccessible {
    
    /// Kind of element
    associatedtype Element
    
    /// Accessible
    var count: Int {get}
    func item(at index: Int) -> Element
    subscript(index: Int) -> Element { get }
}

//
// MARK: - BaseViewModel
open class BaseViewModel {
    
    //
    // MARK: - Variable
    public let disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    public init() {
        
    }
}
