//
//  InspirationQuotation.swift
//  Titan
//
//  Created by Nghia Tran on 1/29/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import RealmSwift

class InspiredQuotation: BaseModel {
    
    //
    // MARK: - Variable
    static let defaultContentJSON = "DefaultQuotation"
    
    dynamic var content: String!
    dynamic var author: String!
    dynamic var imageName: String!
    
    //
    // MARK: - Import
    class func importDefaultQuotation() {
        let bundle = Bundle(identifier: "com.fe.nghiatran.TitanCore")!
        let pathJSON = bundle.url(forResource: InspiredQuotation.defaultContentJSON, withExtension: "json")!
        do {
            let data = try Data(contentsOf: pathJSON, options: Data.ReadingOptions.mappedIfSafe)
            guard let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: String]] else {return}
            
            let quotations = json.map { (item) -> InspiredQuotation in
                
                // Parse
                let content = item["content"]
                let author = item["author"]
                let imagename = item["imageName"]
                
                // Create new model
                let quote = InspiredQuotation()
                quote.content = content
                quote.author = author
                quote.imageName = imagename
                return quote
            }
            
            // Save
            RealmManager.sharedManager.writeSync { realm in
                realm.add(quotations, update: true)
            }
        }
        catch let error {
            Logger.error(error)
        }

    }
}
