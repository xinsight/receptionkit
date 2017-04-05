//
//  DeliveryMethodViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class DeliveryMethodViewController: ReturnToHomeViewController {
    
    var deliveryCompany: String?
    var shouldAskToWait = true
    
    @IBOutlet weak var signatureButton: UIButton!
    @IBOutlet weak var leftReceptionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        signatureButton.setTitle(Text.get("signature"), for: UIControlState())
        leftReceptionButton.setTitle(Text.get("left at reception"), for: UIControlState())
    }


    //
    // Delivery method buttons
    //
    
    @IBAction func signatureButtonTapped(_ sender: AnyObject) {
        shouldAskToWait = true
        segueWithMessage(makeDeliveryFromText() + " requires a signature! @channel")
    }
    
    @IBAction func leftReceptionButtonTapped(_ sender: AnyObject) {
        shouldAskToWait = false
        segueWithMessage(makeDeliveryFromText() + " has been left at reception! @channel")
    }
    
    // Exclude the "from" if the delivery company is unknown
    func makeDeliveryFromText() -> String {
        var messageText = "A delivery"
        if deliveryCompany != "Other" {
            messageText += " from " + deliveryCompany!
        }
        return messageText
    }
    
    // Segue to the thank you controller after sending a SupportKit message
    func segueWithMessage(_ message: String) {
        
        Messaging.sendDeliveryMessage(message);
        
        performSegue(withIdentifier: "DeliveryMethodSelectedSegue", sender: self)
    }

    
    //
    // MARK: - Navigation
    //

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let waitingViewController = segue.destination as? WaitingViewController {
            waitingViewController.shouldAskToWait = shouldAskToWait
        }
    }

}
