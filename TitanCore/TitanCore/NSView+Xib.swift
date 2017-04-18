//
//  NSView+Xib.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - Extension to help initial view from nib easier
// The ID of view my be same name of view
public protocol XIBInitializable {
    
    associatedtype T
    
    static func viewFromNib() -> T?
}

//
// MARK: - Default Extension
public extension XIBInitializable where Self: Identifier {
    
    static func viewFromNib() -> T? {
        
        var topViews: NSArray = []
        let _ = self.xib()?.instantiate(withOwner: self, topLevelObjects: &topViews)
        
        for subView in topViews {
            if let innerView = subView as? T {
                return innerView
            }
        }
        
        return nil
    }
}
