//
//  VisitorViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-24.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorViewController: ReturnToHomeViewController {
    
    // Name of the visitor set by VisitorAskNameViewController
    var visitorName: String?
    
    @IBOutlet weak var knowButton: UIButton!
    @IBOutlet weak var notKnowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        knowButton.setTitle(Text.get("i know"), for: UIControlState())
        notKnowButton.setTitle(Text.get("i don't know"), for: UIControlState())
    }
    
    // Centre align the button text - left-aligned by default
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        knowButton.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    
    //
    // MARK: - Navigation
    //
    
    // Should post message if the visitor does not know who they are looking for
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WaitingViewController {

//            if visitorName == nil || visitorName == "" {
//                sendMessage("Someone is at the reception!")
//            } else {
//                sendMessage("\(visitorName!) is at the reception!")
//            }

            Messaging.sendVisitorMessage(visitorName, contact: nil)
        }

        if let searchResultsViewController = segue.destination as? VisitorSearchResultsTableViewController {
                searchResultsViewController.visitorName = visitorName
        } else if let visitorSearchViewController = segue.destination as? VisitorSearchViewController {
            visitorSearchViewController.visitorName = visitorName
        }
    }

}
