//
//  Contacts.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation
import UIKit

class Contacts {
    var items:[Contact]
    init() {
        self.items = [Contact]()
    }
    
    func downloadSlackContacts() {
        // completionHandler: ([Contact]) -> Void) -> Void {
        
        let urlString = "https://slack.com/api/users.list?token=\(Config.Slack.TOKEN)"
        let url = NSURL(string:urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler:{
            (data, response, error) -> Void in
            
            do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSDictionary
                
                for member:NSDictionary in dict["members"] as! Array {
                    
                    let deleted = member["deleted"] as! Bool
                    if (deleted) {
                        continue
                    }
                    
                    let profile = member["profile"] as! NSDictionary
                    let name = profile["real_name"] as! String
                    let username = member["name"] as! String
                    let avatarUrl = NSURL(string:profile["image_72"] as! String)
                    
                    if (name == "") {
                        continue
                    }
                    
                    let contact = Contact(name: name, username: username, avatarUrl: avatarUrl)
                    contact.title = profile["title"] as? String
                    
                    self.items.append(contact)
                    
                }
                
                self.items = self.items.sort({$0.name < $1.name})
                
            } catch {
                print("error parsing json")
            }
            
        })
        
        task.resume()
        
    }

    
}

class Contact: CustomStringConvertible {
    
    var name: String // Bob Smith
    var username: String // @slack
    var picture: UIImage?
    var avatarUrl: NSURL?
    var title: String? // profile["title"]
    
    init(name: String, username: String, avatarUrl:NSURL?) {
        self.name = name
        self.username = username
        self.avatarUrl = avatarUrl
    }

    var description: String {
        return "name:\(name) username:\(username) title:\(title)"
    }
    
    // Search for all contacts that match a name
    static func search(name: String) -> [Contact] {
        let contacts = [Contact]()

        // TODO:

        // Will return an empty array if not authorized
        return contacts
    }
    
    
    //
    // Private functions
    //
    
}

