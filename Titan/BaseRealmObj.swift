//
//  BaseRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/6/16.
//  Copyright © 2016 fe. All rights reserved.
//

import RealmSwift
import RxSwift

class BaseRealmObj: Object {
    
}

//
// MARK: - Active Record
extension BaseRealmObj {
    
    /// Fetch all
    func fetchAll<T: BaseRealmObj>() -> Observable<Results<T>> {
        let type = type(of: self) as! T.Type
        return RealmManager.sharedManager.fetchAll(type: type)
    }
    
    
    /// First
    func first<T: BaseRealmObj>() -> Observable<T> {
        let type = type(of: self) as! T.Type
        return RealmManager.sharedManager.first(type: type)
    }
}


