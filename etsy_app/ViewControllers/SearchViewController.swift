//
//  SearchViewController.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/4/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    
    // Every time we show the view, lets put the focus on the search field
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchField.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Create a search model with the user inputted keywords
        var searchModel = SearchModel()
        searchModel.keyword = searchField.text
        
        // Pass model to the next view controller
        var destination = segue.destinationViewController as ResultsViewController
        destination.searchModel = searchModel	
    }
}
