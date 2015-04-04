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
    class func search(searchModel: SearchModel, onSuccess: (newModel: SearchModel) -> Void) {
        var api_key = "liwecjs0c3ssk6let4p1wqt9"
        var url = "https://api.etsy.com/v2/listings/active?api_key=\(api_key)&includes=MainImage&keywords=\(searchModel.keyword)"
        
        Alamofire.request(.GET, url).responseJSON { (request, response, json, error) in
            var newModel = SearchModel()
            let resp = JSON(json!)
            var results: [Listing] = []
            
            for(key: String, subJSON: JSON) in resp["results"] {
                var newListing = Listing()
                newListing.title = subJSON["title"].stringValue
                newListing.imageURL = subJSON["MainImage"]["url_75x75"].stringValue
                results.append(newListing)
            }
            
            newModel.numResults = resp["pagination"]["effective_limit"].intValue
            newModel.results = results
            
            onSuccess(newModel: newModel)
        }
    }
}
