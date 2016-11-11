//
//  TwoWayBinding.swift
//  Titan
//
//  Created by Nghia Tran on 11/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator <-> { precedence 130 associativity left }

func <-><T: Comparable>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
        .distinctUntilChanged()
        .bindTo(property)
    
    let propertyToVariable = property
        .distinctUntilChanged()
        .bindTo(variable)
    
    return Disposables.create(variableToProperty, propertyToVariable)
}

func <-><T: Comparable>(left: Variable<T>, right: Variable<T>) -> Disposable {
    let leftToRight = left.asObservable()
        .distinctUntilChanged()
        .bindTo(right)
    
    let rightToLeft = right.asObservable()
        .distinctUntilChanged()
        .bindTo(left)
    
    return Disposables.create(leftToRight, rightToLeft)
}
