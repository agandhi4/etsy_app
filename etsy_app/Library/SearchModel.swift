//
//  SearchModel.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/4/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit

class SearchModel: NSObject {
    var keyword: String!
    
    var results: [Listing]!
    var numResults: Int!
    
    override init() {
        super.init()
        
        // Set default values
        keyword = ""
        
        results = []
        numResults = 0
    }
}
