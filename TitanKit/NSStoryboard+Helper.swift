//
//  Storyboard+Helper.swift
//  TitanKit
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

public extension NSStoryboard {
    public class func StoryboardWithName(storyboardName: StoryboardName) -> NSStoryboard {
        switch storyboardName {
        case .Connection:
            return NSStoryboard(name: "Connection.storyboard", bundle: nil)
        }
    }
    
    public func hasSomething() -> Bool {
        return true
    }
}
