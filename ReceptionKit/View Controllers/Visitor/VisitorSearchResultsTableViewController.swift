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
        self.view.backgroundColor = UIColor.white
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        searchResults = appDelegate.contacts.items

    }
    
    //
    // MARK: - Table view data source
    //

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ContactTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        let contact = searchResults![indexPath.row]
        cell.contactNameLabel.text = contact.name
        cell.contactTitleLabel.text = contact.title
        
        if (contact.picture != nil) {
            cell.contactImage.image = contact.picture
        } else {
            
            if let url = contact.avatarUrl {
            
                let session = URLSession.shared
                let task = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                    if let _data = data {
                        DispatchQueue.main.async(execute: {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = searchResults![indexPath.row]
        
        Messaging.sendVisitorMessage(visitorName, contact: contact)
        
        performSegue(withIdentifier: "SelectedContact", sender: self)
    }
    

}
