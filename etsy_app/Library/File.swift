//
//  File.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/5/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit

class File: NSObject {
    var fileName: String!
    
    init(file: String) {
        fileName = file
    }
    
    func read() -> String {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        var contents = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return contents.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}
