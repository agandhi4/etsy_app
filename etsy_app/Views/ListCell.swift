//
//  ListCell.swift
//  etsy_app
//
//  Created by Aakash Gandhi on 4/4/15.
//  Copyright (c) 2015 Aakash Gandhi. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var listing: Listing! {
        didSet {
            self.listImage.sd_setImageWithURL(NSURL(string: listing.imageURL))
            self.title.text = listing.title
        }
    }
}
