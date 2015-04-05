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
    var etsyService = EtsyService()
    
    @IBOutlet weak var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100;
        
        showSpinner()
        startSearch()
    }
    
    func startSearch() {
        etsyService.search(searchModel, onSuccess: setModel, onFailure: showError)
    }
    
    func setModel(newModel: SearchModel) {
        searchModel.results += newModel.results
        searchModel.numResults = newModel.numResults
        
        // We need to refresh the table in the main thread, since this will be called from 
        // a worker thread created by the network response
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
    
    func showError(error: NSError) {
        var alert = UIAlertController(title: "Network Error", message: "Error contacting Etsy, please try again later.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        hideSpinner()
    }
    
    func showSpinner() {
        // Cheap and easy way to get spinner
        tableView.tableFooterView = footerView
    }
    
    func hideSpinner() {
        tableView.tableFooterView = UIView()
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var row = self.tableView.indexPathForSelectedRow()!.row
        var listing = searchModel.results[row]
        
        var destination = segue.destinationViewController as DetailViewController
        destination.listing = listing
    }

}

// Segregate the tableview datasource and delegate methods visually
extension ResultsViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return searchModel.results.count > 0 ? 1 : 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel.results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // If we have reached the last row, we may need to lazy load more results
        if ((indexPath.row + 1) == searchModel.results.count) {
            if (searchModel.hasMore()) {
                searchModel.page++
                startSearch()
            } else {
                // If there are no more results, remove the spinner
                hideSpinner()
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell") as ListCell
        cell.listing = searchModel.results[indexPath.row]
        return cell
    }
}
