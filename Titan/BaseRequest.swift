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
    
    var param: Parameters? {get}
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)>
    
    func toDirver() -> Driver<Response>
}

//
// MARK: - BaseRequest
class BaseRequest {
    
    //
    // MARK: - Variable
    typealias Parameter = [String: Any]
    internal var _param: Parameter?
    
    //
    // MARK: - Init
    init() {
        
    }
    
    init(param: Parameter) {
        self._param = param
    }
    
    var param: [String: Any]? {
        get {
            return _param
        }
    }
    
}

//
// MARK: - Default implementation
extension Request {
    
    var basePath: String {
        get {
            return Constants.Endpoint.BaseURL
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var url: String {
        return basePath + endpoint
    }
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)> {
        return RxAlamofire
            .requestJSON(self.httpMethod, self.url)
            .debug()
            .catchError{ error in
                return Observable.never()
        }
    }
}
