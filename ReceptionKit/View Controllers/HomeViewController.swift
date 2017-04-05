//
//  HomeViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class HomeViewController: ThemedViewController {

    @IBOutlet weak var languageButton: UIBarButtonItem!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var visitorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the logo if ShowLogo is enabled
        if (Config.General.ShowLogo) {
            navigationItem.titleView = UIImageView(image: UIImage(named: "CompanyLogo"))
        } else {
            navigationItem.title = Config.General.Company
        }
        
        // Hide the language toggle if ShowLanguageToggle is disabled
        if (!Config.General.ShowLanguageToggle) {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @IBAction func languageButtonTapped(_ sender: AnyObject) {
        if languageButton.title != "English" {
            languageButton.title = "English"
        } else {
            languageButton.title = "français"
        }
        Text.swapLanguage()
        
        // The text on this view has to be manually updated
        deliveryButton.setTitle(Text.get("delivery"), for: UIControlState())
        visitorButton.setTitle(Text.get("visitor"), for: UIControlState())
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Text.get("back"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

}
