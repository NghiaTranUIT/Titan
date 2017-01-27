//
//  SaveObjectRequest.swift
//  Titan
//
//  Created by Nghia Tran on 11/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class SaveObjectRequest<Object: BaseMappable>: Requestable {
    
    typealias T = Object
    
    //
    // MARK: - Variable
    var param: Parameters?
    var httpMethod: HTTPMethod {get {return .post}}
    var endpoint: String {get {return Constants.Endpoint.SaveObject}}
    
    
    //
    // MARK: - Init
    init(param: Parameters?) {
        self.param = param
    }
    
    
    /// Decode
    func decode(data: Any) -> T? {
        guard let data = data as? [String: Any] else {return nil}
        return Mapper<T>().map(JSON: data)
    }
}
