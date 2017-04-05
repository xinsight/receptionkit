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
        nameTextField.borderStyle = UITextBorderStyle.roundedRect
        lookingForLabel.text = Text.get("looking for")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }

    
    //
    // MARK: - UITextFieldDelegate
    //
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contacts = appDelegate.contacts
        
        searchResults = contacts.items

//        if let text = nameTextField?.text {
//            searchResults = Contact.search(text)
//        }

        // Check if the person the visitor is searching for exists
//        if searchResults.count > 0 {
            performSegue(withIdentifier: "VisitorNameSearchSegue", sender: self)
//        } else {
//            performSegueWithIdentifier("VisitorNameInvalidSearchSegue", sender: self)
//        }
        
        return false
    }
    

    //
    // MARK: - Navigation
    //

    // Post a message if the person the visitor is looking for does not exist
    // Otherwise show the result of the search
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let visitorSearchResultsTableViewController = segue.destination as? VisitorSearchResultsTableViewController {
            // Exists
            visitorSearchResultsTableViewController.visitorName = visitorName
            visitorSearchResultsTableViewController.searchQuery = nameTextField.text
            visitorSearchResultsTableViewController.searchResults = searchResults
        } else if let waitingViewController = segue.destination as? WaitingViewController {
            // Does not exist
            print("???")
//            if visitorName == nil || visitorName == "" {
//                sendMessage("Someone is at the reception looking for \(nameTextField.text)!")
//            } else {
//                sendMessage("\(visitorName!) is at the reception looking for \(nameTextField.text)!")
//            }
        }
    }

}
