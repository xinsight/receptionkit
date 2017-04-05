//
//  Messaging.swift
//  ReceptionKit
//
//  Created by Jay Moore on 2015-08-14.
//  Copyright © 2015 Andy Cho. All rights reserved.
//

import Foundation

class Messaging {

    static func buildRequest() -> NSMutableURLRequest {
        let url = URL(string: "https://hooks.slack.com/services/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")
        let request = NSMutableURLRequest(url:url!)
        request.httpMethod = "POST"
        return request
    }
    
    static func sendDeliveryMessage(_ message:String) {

        let request = buildRequest()
  
        let dict = [
            "channel": Config.Slack.CHANNEL,
            "username": "receptionist",
            "link_names": "1", // makes @foo into a link (and notifies)
            "text": message,
            "icon_emoji": ":package:"
        ]

        do {
            let json = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted);
            if let jsonString = NSString(data: json, encoding: String.Encoding.utf8.rawValue) {
                let payload = "payload=\(jsonString)"
                request.httpBody = payload.data(using: String.Encoding.utf8)
            }

            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                if (error != nil) {
                    print("Error: \(error)")
                }
            }
            task.resume()
            
        } catch {
            print("unable to parse into json: \(dict)")
        }
        
    }
    
    
    static func sendVisitorMessage(_ visitorName:String?, contact:Contact?) {

        let text:String
        if let name = visitorName {
            if let _contact = contact {
                text = "\(name) is at reception looking for @\(_contact.username)!"
            } else {
                text = ("\(name) is at reception!")
            }
        } else {
            if let _contact = contact {
                text = "Someone is at reception looking for @\(_contact.username)!"
            } else {
                text = "Someone is at reception"
            }
        }
        
        let request = buildRequest()
        
        let dict = [
            "channel": Config.Slack.CHANNEL,
            "username": "receptionist",
            "link_names": "1", // makes @foo into a link (and notifies)
            "text": text,
            "icon_emoji": ":phone:"
        ]
        
        do {
            let json = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted);
            if let jsonString = NSString(data: json, encoding: String.Encoding.utf8.rawValue) {
                let payload = "payload=\(jsonString)"
                request.httpBody = payload.data(using: String.Encoding.utf8)
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                if (error != nil) {
                    print("Error: \(error)")
                }
            }
            task.resume()
            
        } catch {
            print("unable to parse into json: \(dict)")
        }
        
        
    }
    
}
