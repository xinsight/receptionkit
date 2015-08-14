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
        let url = NSURL(string: "https://hooks.slack.com/services/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")
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST"
        return request
    }
    
    static func sendDeliveryMessage(message:String) {

        let request = buildRequest()
  
        let dict = [
            "channel": Config.Slack.CHANNEL,
            "username": "receptionist",
            "link_names": "1", // makes @foo into a link (and notifies)
            "text": "[test] \(message)", // FIXME:
            "icon_emoji": ":package:"
        ]

        do {
            let json = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted);
            if let jsonString = NSString(data: json, encoding: NSUTF8StringEncoding) {
                let payload = "payload=\(jsonString)"
                request.HTTPBody = payload.dataUsingEncoding(NSUTF8StringEncoding)
            }
            
            let session = NSURLSession.sharedSession()
            let task = session.downloadTaskWithRequest(request) { (url, response, error) -> Void in
                if (error != nil) {
                    print("Error: \(error)")
                }
            }
            task.resume()
            
        } catch {
            print("unable to parse into json: \(dict)")
        }
        
    }
    
    
    static func sendVisitorMessage(visitorName:String?, contact:Contact?) {

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
            "text": "[test] \(text)",
            "icon_emoji": ":phone:"
        ]
        
        do {
            let json = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted);
            if let jsonString = NSString(data: json, encoding: NSUTF8StringEncoding) {
                let payload = "payload=\(jsonString)"
                request.HTTPBody = payload.dataUsingEncoding(NSUTF8StringEncoding)
            }
            
            let session = NSURLSession.sharedSession()
            let task = session.downloadTaskWithRequest(request) { (url, response, error) -> Void in
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
