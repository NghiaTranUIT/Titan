//
//  BaseRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import Alamofire
import ObjectMapper
import PromiseKit

//
// MARK: - Request protocol
protocol Request: Action, URLRequestConvertible {
    
    associatedtype T
    
    var basePath: String {get}
    
    var endpoint: String {get}
    
    var httpMethod: HTTPMethod {get}
    
    var param: Parameters? {get set}
    
    var addionalHeader: HeaderParameter? {get}
    
    var parameterEncoding: ParameterEncoding {get}
    
    func toAlamofireObservable() -> Promise<T>
    
    init()
}

//
// MARK: - Conform URLConvitible from Alamofire
extension Request {
    func asURLRequest() -> URLRequest {
        return self.buildURLRequest()
    }
}

//
// MARK: - Default implementation
extension Request {
    
    typealias Parameters = [String: Any]
    typealias HeaderParameter = [String: String]
    typealias JSONDictionary = [String: Any]
    
    var basePath: String {
        get {
            return Constants.Endpoint.BaseURL
        }
    }
    
    var param: Parameters? {
        get {
            return nil
        }
        set {
            param = newValue
        }
    }
    
    var addionalHeader: HeaderParameter? {
        get {
            return nil
        }
    }
    
    var defaultHeader: HeaderParameter {
        get {
            return ["Accept": "application/json"]
        }
    }
    
    var urlPath: String {
        return basePath + endpoint
    }
    
    var url: URL {
        return URL(string: urlPath)!
    }
    
    var parameterEncoding: ParameterEncoding {
        get {
            return JSONEncoding.default
        }
    }
    
    func toAlamofireObservable() -> Promise<T> {
        
        return Promise { fulfill, reject in
            guard let urlRequest = try? self.asURLRequest() else {
                reject(NSError.unknowError())
                return
            }
            
            Alamofire.request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON(completionHandler: { (response) in
                    
                    // Check error
                    if let error = response.result.error {
                        reject(error as NSError)
                        return
                    }
                    
                    // Check Response
                    guard let data = response.result.value else {
                        reject(NSError.jsonMapperError())
                        return
                    }
                    
                    // Parse here
                    let result = JSONDecoder.shared.decodeObject(data) as! T
                    fulfill(result)
                })
        }
    }
    
    init(param: Parameters?) {
        self.init()
        self.param = param
    }
    
    func buildURLRequest() -> URLRequest {
        
        // Init
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.timeoutInterval = TimeInterval(10 * 1000)
        
        // Encode param
        var request = try! self.parameterEncoding.encode(urlRequest, with: self.param)
        
        // Add addional Header if need
        if let additinalHeaders = self.addionalHeader {
            for (key, value) in additinalHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
