//
//  MacBaseWindowController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class MacBaseWindowController: BaseWindowController {

    /// Get controller
    class func controllerFromStoryboard<T>(type: T.Type, storyboardName: StoryboardName) -> T {
        let storyboard = StoryboardManager.storyboard(with: storyboardName)
        return storyboard.instantiateController(withIdentifier: String(describing: type)) as! T
    }

}
