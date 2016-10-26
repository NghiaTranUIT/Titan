//
//  BaseRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import ReSwift
import RxAlamofire
import Alamofire

//
// MARK: - Request protocol
protocol Request: Action {
    
    associatedtype Response
    
    var basePath: String {get}
    
    var endpoint: String {get}
    
    var httpMethod: HTTPMethod {get}
    
    var param: Parameters? {get set}
    
    var header: HeaderParameter? {get}
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)>
    
    func toDirver() -> Driver<Response>
    
    init()
}

//
// MARK: - Default implementation
extension Request {
    
    typealias Parameters = [String: Any]
    typealias HeaderParameter = [String: String]
    
    var basePath: String {
        get {
            return Constants.Endpoint.BaseURL
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var param: Parameters? {
        get {
            return nil
        }
        set {
            param = newValue
        }
    }
    
    var header: HeaderParameter? {
        get {
            return ["Accept": "application/json"]
        }
    }
    
    var url: String {
        return basePath + endpoint
    }
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)> {
        return SessionManager.default
            .rx
            .request(self.httpMethod, self.url, parameters: self.param, encoding: JSONEncoding.default, headers: self.header)
            .flatMapLatest{
                $0
                .validate()
                .rx.responseJSON()
            }
    }
    
    init(param: Parameters?) {
        self.init()
        self.param = param
    }
}
