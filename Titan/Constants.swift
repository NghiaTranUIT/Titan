//
//  Constants.swift
//  Titan
//
//  Created by Nghia Tran Vinh on 9/25/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

struct Constants {
    
    //
    // MARK: - App
    struct App {
        static let Version = "1.0.0"
    }
    
    //
    // MARK: - Logger
    struct Logger {
        
        // Slack
        struct Slack {
            static let Endpoint = "<Slack endpoint>"
            static let Token = "<Your token>"
            static let ErrorChannel = "<Error channel name>"
            static let ResponseChannel = "<Response channel name>"
            static let ResponseChannel_Webhook = "https://hooks.slack.com/services/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"
            static let ErrorChannel_Webhook = "https://hooks.slack.com/services/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"
        }
    }
}
