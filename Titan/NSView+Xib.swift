
//
//  NSView+Xib.swift
//  Titan
//
//  Created by Nghia Tran on 2/5/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Cocoa

//
// MARK: - Extension to help initial view from nib easier
// The ID of view my be same name of view
protocol XIBInitializable {
    
    associatedtype T
    
    static func viewFromNib() -> T?
}

extension XIBInitializable where Self: Identifier {
    
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
