//
//  ResultsViewController.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/4/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    var searchModel: SearchModel!
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100;
        
        // Cheap and easy way to get spinner
        tableView.tableFooterView = footerView
        startSearch()
    }
    
    func startSearch() {
        EtsyService.search(searchModel, onSuccess: setModel)
    }
    
    func setModel(newModel: SearchModel) {
        searchModel.results += newModel.results
        searchModel.numResults = newModel.numResults

        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ResultsViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return searchModel.results.count > 0 ? 1 : 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel.results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if ((indexPath.row + 1) == searchModel.results.count) {
            if (searchModel.hasMore()) {
                searchModel.page++
                startSearch()
            } else {
                self.tableView.tableFooterView = UIView()
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell") as ListCell
        cell.listing = searchModel.results[indexPath.row]
        return cell
    }
}
