//
//  VisitorSearchResultsTableViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorSearchResultsTableViewController: ReturnToHomeTableViewController {

    var visitorName: String?
    var searchQuery: String?
    var searchResults: [Contact]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Overwrite the theme - table should be white
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    //
    // MARK: - Table view data source
    //

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults!.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ContactTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactTableViewCell

        let contact = searchResults![indexPath.row]
        cell.contactNameLabel.text = contact.name
        
        if (contact.picture != nil) {
            cell.contactImage.image = contact.picture
        } else {
            
            if let url = contact.avatarUrl {
            
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                    if let _data = data {
                        dispatch_async(dispatch_get_main_queue(), {
                            cell.contactImage.image = UIImage(data:_data)
                        })
                    }
                })
                task.resume()
                
            }
            
            cell.contactImage.image = UIImage(named: "UnknownContact")
        }
        cell.contactImage.layer.cornerRadius = 42.0
        cell.contactImage.layer.masksToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contact = searchResults![indexPath.row]
        if visitorName == nil || visitorName == "" {
            sendMessage("Someone is at the reception looking for \(contact.name)!")
        } else {
            sendMessage("\(visitorName!) is at the reception looking for \(contact.name)!")
        }
        performSegueWithIdentifier("SelectedContact", sender: self)
    }
    

}
