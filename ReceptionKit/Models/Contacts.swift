//
//  Contacts.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import Foundation
import UIKit
//import AddressBook

//class ContactPhone {
//    var type: String
//    var number: String
//    
//    init(type: String, number: String) {
//        self.type = type
//        self.number = number
//    }
//    
//    func isWorkPhone() -> Bool {
//        return self.type == "_$!<Work>!$_"
//    }
//    
//    func isMobilePhone() -> Bool {
//        return self.type == "_$!<Mobile>!$_"
//    }
//}

class Contacts {
    var contacts:[Contact]
    init() {
        self.contacts = []()
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
    }

    
    static func downloadSlackContacts(completionHandler: ([Contact]) -> Void) -> Void {

        let contact = Contact(name:"Bo Boo", username:"boboo", avatarUrl:NSURL(string:"http://foo.com/foo.jpg"))
        var contacts = [Contact]()
        contacts.append(contact)

        let url = NSURL(string:"https://slack.com/api/users.list?token=xoxp-2336072268-2747645885-9036602146-8bcc6f")
//        let request = NSURLRequest(url);
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler:{
            (data, response, error) -> Void in
            
//            var err:NSError?
//            let dict = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:&err) as NSDictionary
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
                    let avatarUrl = NSURL(string:profile["image_48"] as! String)
                    
                    let contact = Contact(name: name, username: username, avatarUrl: avatarUrl)
                    print("name: \(name) \(username)")
                    contacts.append(contact)
                    
                    // TODO: sort
                }
                
                completionHandler(contacts)
                
            } catch {
                print("error parsing json")
            }
            
            
        })
        
        task.resume()
 
    }
    
    // Check to see if the user has granted the address book permission, ask for permission if not
    // Returns true if authorized, false if not
//    static func isAuthorized() -> Bool {
//        // Get the authorization if needed
//        let authStatus = ABAddressBookGetAuthorizationStatus()
//        if (authStatus == ABAuthorizationStatus.Denied ||
//            authStatus == ABAuthorizationStatus.Restricted) {
//                print("No permission to access the contacts")
//        } else if (authStatus == ABAuthorizationStatus.NotDetermined) {
//            ABAddressBookRequestAccessWithCompletion(nil) { (granted: Bool, error: CFError!) in
//                print("Successfully got permission for the contacts")
//            }
//        }
//        
//        // Need to refetch the status if it was updated
//        return ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized
//    }
    
    
    // Search for all contacts that match a name
    static func search(name: String) -> [Contact] {
        let contacts = [Contact]()

        // TODO:
        
        
//        if (isAuthorized()) {
//            let addressBook: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeUnretainedValue()
//            let query = name as CFString
//            let people = ABAddressBookCopyPeopleWithName(addressBook, query).takeRetainedValue() as Array
//            
//            for person:ABRecordRef in people {
//                let contactName: String = ABRecordCopyCompositeName(person).takeRetainedValue() as String
//                var contactPhoneNumbers = getPhoneNumbers(person, property: kABPersonPhoneProperty)
//                
//                let contactPictureDataOptional = ABPersonCopyImageData(person)
//                var contactPicture: UIImage?
//                if (contactPictureDataOptional != nil) {
//                    let contactPictureData = ABPersonCopyImageData(person).takeRetainedValue() as NSData
//                    contactPicture = UIImage(data: contactPictureData)
//                }
//                
//                contacts.append(Contact(name: contactName, phones: contactPhoneNumbers, picture: contactPicture))
//            }
//        }

        // Will return an empty array if not authorized
        return contacts
    }
    
    
    //
    // Private functions
    //
    
    // Get a property from a ABPerson, returns an array of Strings that matches the value
//    static func getPhoneNumbers(person: ABRecordRef, property: ABPropertyID) -> [ContactPhone] {
//        var propertyValues = [ContactPhone]()
//        
//        let personProperty: ABMultiValueRef = ABRecordCopyValue(person, property).takeRetainedValue() as ABMultiValueRef
//        let personPropertyValues = ABMultiValueCopyArrayOfAllValues(personProperty) // Returns nil if empty
//
//        if (personPropertyValues != nil) {
//            let properties = personPropertyValues.takeUnretainedValue() as NSArray
//            for (index, property) in properties.enumerate() {
//                let propertyLabel = ABMultiValueCopyLabelAtIndex(personProperty, index).takeRetainedValue() as String
//                let propertyValue = property as! String
//                let phone = ContactPhone(type: propertyLabel, number: propertyValue)
//                propertyValues.append(phone)
//            }
//        }
//        return propertyValues
//    }
    
}

