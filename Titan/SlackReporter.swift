//
//  SlackReport.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Alamofire

enum SlackReporterType {
    case Error
    case Response
}

struct SlackReporter {
    
    let type: SlackReporterType
    
    // Slack
    private lazy var usernameSlack: String = {
        switch self.type {
        case .Error:
            return "Susu"
        case .Response:
            return "Rolex"
        }
    }()
    
    private lazy var icon_emoji: String = {
        switch self.type {
        case .Error:
            return ":dog:"
        case .Response:
            return ":stopwatch:"
        }
    }()
    
    // Data
    private var error: NSError?
    private var responseTime: CGFloat? = 0
    private var apiName: String = ""
    private var fileName: String = ""
    private var functionName: String = ""
    private var line: String = ""
    private var additionInfo: String = ""
    private lazy var buildNumber: String? = {
        guard let appInfo = NSBundle.mainBundle().infoDictionary else {return nil}
        let appVersion = appInfo[kCFBundleVersionKey as String] as? String
        return appVersion
    }()
    
    init(error: NSError?, fileName: String, functionName: String, line: Int) {
        self.type = .Error
        self.error = error
        self.functionName = functionName
        self.line = String(line)
        
        // Filename
        let componment = fileName.componentsSeparatedByString("/")
        if let _fileName = componment.last {
            self.fileName = _fileName
        }
        else {
            self.fileName = "unknow"
        }
    }
    
    init(responseTime: CGFloat?, apiName: String, response: Alamofire.Response<AnyObject, NSError>?) {
        self.type = .Response
        self.responseTime = responseTime ?? 0
        self.apiName = apiName
        self.additionInfo = self.infoTextFromResponse(response)
    }
    
    mutating func toParam() -> [String: String] {
        let text = self.toLog()
        let username = self.usernameSlack
        let icon = self.icon_emoji
        
        let param: [String: String] = ["username": username,
                                       "icon_emoji": icon,
                                       "text": text]
        return param
    }
    
    private func infoTextFromResponse(response: Alamofire.Response<AnyObject, NSError>?) -> String {
        guard let response = response else {return ""}
        
        var text: String = ""
        if let URL = response.request?.URL?.absoluteString {
            text += " *URL* = \(URL)"
        }
        
        if let UUID = response.request?.allHTTPHeaderFields?[Constants.APIKey.X_Request_ID] {
            text += " *UUID* = \(UUID)"
        }
        
        return text
    }
    
    private mutating func toLog() -> String {
        
        // Current User first
        var text: String = ""
        if let currentUser = UserObj.currentUser {
            text += ":dark_sunglasses: \(currentUser.objectId)"
            if let username = currentUser.username {
                text += "|\(username)"
            }
        }
        
        // Build version
        if let buildVersion = self.buildNumber {
            text += " :iphone: \(buildVersion)"
        }
        
        // Info
        switch self.type {
        case .Error:
            text += ":round_pushpin:\(fileName):\(line) :mag_right:\(functionName)"
            if let error = self.error {
                text += " 👉 \(error.localizedDescription)"
            }
            else {
                text += " 👉 Unknow"
            }
            return text
        case .Response:
            text += ":round_pushpin:\(self.apiName):"
            if let responseTime = self.responseTime {
                text += " 👉 \(responseTime)"
            }
            else {
                text += " 👉 Unknow"
            }
            text += " :rocket: \(self.additionInfo)"
            
            return text
        }
        
    }
}

class SlackReporter: NSObject {
    
    // MARK:
    // MARK: Variable
    private let Token = Constants.Slack.Token
    private let ErrorChannel = Constants.Slack.ErrorChannel
    private let ResponseChannel = Constants.Slack.ResponseChannel
    private lazy var URLErrorChannel: String = {
        //return "https://feelsapp.slack.com/services/hooks/slackbot?token=\(self.Token)&channel=\(self.ErrorChannel)"
        return Constants.Slack.ErrorChannel_Webhook
    }()
    private lazy var URLResponseChannel: String = {
        //return "https://feelsapp.slack.com/services/hooks/slackbot?token=\(self.Token)&channel=\(self.ResponseChannel)"
        return Constants.Slack.ResponseChannel_Webhook
    }()
    
    // MARK:
    // MARK: Public
    func reportErrorData(data: SlackReporterData) {
        
        // Build param
        var data = data
        let param = data.toParam()
        
        Alamofire.request(.POST, self.URLErrorChannel, parameters: param, encoding: ParameterEncoding.JSON)
            .response { response in
                
        }
    }
    
    func reportResponseData(data: SlackReporterData) {
        
        // Build param
        var data = data
        let param = data.toParam()
        
        Alamofire.request(.POST, self.URLResponseChannel, parameters: param, encoding: ParameterEncoding.JSON)
            .response { response in
                
        }
    }
    
    // MARK:
    // MARK: Private
    class var shareInstance : SlackReporter {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: SlackReporter? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = SlackReporter()
        }
        
        return Static.instance!
    }
    
}

extension SlackReporter {
    // Test
    func testSlackReport() {
        let error = NSError.errorWithMessage("Hi, I'm from Error Report")
        let data = SlackReporterData(error: error, fileName: #file, functionName: #function, line:#line)
        self.reportErrorData(data)
    }
    
    // Test
    func testSlackResponseReport() {
        let data = SlackReporterData(responseTime: 0.2, apiName: "TestAPIName", response: nil)
        self.reportResponseData(data)
    }
}
