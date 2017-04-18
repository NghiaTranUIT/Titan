//
//  StoryboardManager.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

enum StoryboardName: String {
    case Main
    case DetailConnection
}

class StoryboardManager {

    /// Get storyboard with name in current bundle
    class func storyboard(with name: StoryboardName) -> NSStoryboard {
        return NSStoryboard(name: name.rawValue, bundle: nil)
    }
}
