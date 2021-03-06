//
//  VisitorSearchViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorSearchViewController: ReturnToHomeViewController, UITextFieldDelegate {

    var visitorName: String?
    var searchResults = [Contact]()
    
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.placeholder = Text.get("wizard of oz")
        lookingForLabel.text = Text.get("looking for")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }

    
    //
    // MARK: - UITextFieldDelegate
    //
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchResults = Contact.search(nameTextField.text)

        // Check if the person the visitor is searching for exists
        if searchResults.count > 0 {
            performSegueWithIdentifier("VisitorNameSearchSegue", sender: self)
        } else {
            performSegueWithIdentifier("VisitorNameInvalidSearchSegue", sender: self)
        }
        
        return false
    }
    

    //
    // MARK: - Navigation
    //

    // Post a message if the person the visitor is looking for does not exist
    // Otherwise show the result of the search
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let visitorSearchResultsTableViewController = segue.destinationViewController as? VisitorSearchResultsTableViewController {
            // Exists
            visitorSearchResultsTableViewController.visitorName = visitorName
            visitorSearchResultsTableViewController.searchQuery = nameTextField.text
            visitorSearchResultsTableViewController.searchResults = searchResults
        } else if let waitingViewController = segue.destinationViewController as? WaitingViewController {
            // Does not exist
            if visitorName == nil || visitorName == "" {
                sendMessage("Someone is at the reception looking for \(nameTextField.text)!")
            } else {
                sendMessage("\(visitorName!) is at the reception looking for \(nameTextField.text)!")
            }
        }
    }

}
