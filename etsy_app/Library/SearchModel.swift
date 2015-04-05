//
//  SearchModel.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/4/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit

class SearchModel: NSObject {
    // Conditions for the search
    var keyword = ""
    
    // Results
    var results: [Listing] = []
    
    // Control of pagination
    var page = 1
    var perPage = 25
    var numResults = 0
    
    func hasMore() -> Bool {
        if ((page * perPage) < numResults) {
            return true
        } else {
            return false
        }
    }
}
