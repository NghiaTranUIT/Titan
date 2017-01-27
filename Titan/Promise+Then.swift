//
//  Promise+Then.swift
//  Titan
//
//  Created by Nghia Tran on 1/25/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import PromiseKit

//
// MARK: - Promise + Main Thread
/// Warper to ensure promise is executed in Main Thread
extension Promise {
    
    func thenOnMainTheard<U>(execute body: @escaping (T) throws -> PromiseKit.Promise<U>) -> PromiseKit.Promise<U> {
        return self.then(on: DispatchQueue.main, execute: body)
    }
    
    func thenOnMainThread<U>(_ body: @escaping (T) throws -> U) -> PromiseKit.Promise<U> {
        return self.then(on: DispatchQueue.main, execute: body)
    }
}
