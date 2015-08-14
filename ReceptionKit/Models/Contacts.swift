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
        
        let url = NSURL(string:"https://slack.com/api/users.list?token=xoxp-2336072268-2747645885-9036602146-8bcc6f")
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
                    
                    let contact = Contact(name: name, username: username, avatarUrl: avatarUrl)
                    print("name: \(name) \(username)")
                    self.items.append(contact)
                    
                    // TODO: sort
                }
                
                //completionHandler(contacts)
                
            } catch {
                print("error parsing json")
            }
            
        })
        
        task.resume()
        
    }

    
}

class Contact {
    
    var name: String // Bob Smith
    var username: String // @slack
    var picture: UIImage?
    var avatarUrl: NSURL?
    
    init(name: String, username: String, avatarUrl:NSURL?) {
        self.name = name
        self.username = username
        self.avatarUrl = avatarUrl
    }

    func description() {
        print("name:\(name) username:\(username)")
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

