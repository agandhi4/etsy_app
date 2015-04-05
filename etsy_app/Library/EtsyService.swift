//
//  EtsyService.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/4/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EtsyService: NSObject {
    var api_key: String!
    
    override init() {
        super.init()
        
        // So we don't have the api key in the code or in source control
        api_key = File(file: "api_key").read()
    }
    
    func search(searchModel: SearchModel, onSuccess: (newModel: SearchModel) -> Void) {
        var url = createSearchURL(searchModel)
        
        Alamofire.request(.GET, url).responseJSON { (request, response, json, error) in
            onSuccess(newModel: self.serializeResponse(JSON(json!)))
        }
    }
    
    // Contain the handling of the service response to one method
    func serializeResponse(json: JSON) -> SearchModel {
        var newModel = SearchModel()
        var results: [Listing] = []
        
        for(key: String, subJSON: JSON) in json["results"] {
            var newListing = Listing()
            newListing.title = subJSON["title"].stringValue
            newListing.imageURL = subJSON["MainImage"]["url_75x75"].stringValue
            results.append(newListing)
        }
        
        newModel.numResults = json["count"].intValue
        newModel.results = results
        
        return newModel
    }
    
    func createSearchURL(searchModel: SearchModel) -> String {
        var escapedKeywords = searchModel.keyword.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        return "https://api.etsy.com/v2/listings/active?api_key=\(api_key)&includes=MainImage&keywords=\(escapedKeywords)&page=\(searchModel.page)"
        
    }
}
