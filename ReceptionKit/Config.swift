//
//  Config.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-29.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

class Config {
    
    class General {
        // Change to false if the logo at the top should not show
        static let ShowLogo = true
        
        // Change to false if the language toggle in the top right should not be displayed
        static let ShowLanguageToggle = true
        
        // Time in seconds for when to reset back to the main screen
        static let Timeout = 60.0
    }
    
    class Colour {
        // Colour of the navigation bar
        static let NavigationBar = 0x458FA8
        
        // Colour of the background
        static let Background = NavigationBar
    }
    
    struct Slack {

        static let TOKEN = "xoxp-2336072268-2747645885-9036602146-8bcc6f";

//        let CHANNEL = "Receptionist";
        static let CHANNEL = "@jay";
        
        // Name of the receptionist that appears in Slack
//        static let Name = "Receptionist"
        
        // If you want a profile picture for the receptionist in Slack,
        // set a Gravatar for an email and replace the following
//        static let Email = "receptionist@example.com"
    }
    
}
