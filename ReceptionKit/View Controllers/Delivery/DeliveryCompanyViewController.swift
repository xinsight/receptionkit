//
//  DeliveryCompanyViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class DeliveryCompanyViewController: ReturnToHomeViewController {

    var deliveryCompany: String?
    let deliverySelectedSegue = "DeliveryCompanySelectedSegue"
    
    @IBOutlet weak var upsButton: UIButton!
    @IBOutlet weak var fedExButton: UIButton!
    @IBOutlet weak var canadaPostButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the language
        otherButton.setTitle(Text.get("other"), forState: UIControlState.Normal)
        
        // Make sure that the button images are not skewed
        upsButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        fedExButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        canadaPostButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    
    //
    // Delivery company button taps
    //
    
    @IBAction func upsButtonTapped(sender: AnyObject) {
        deliveryCompany = "UPS"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    
    @IBAction func fedExButtonTapped(sender: AnyObject) {
        deliveryCompany = "FedEx"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    
    @IBAction func canadaPostButtonTapped(sender: AnyObject) {
        deliveryCompany = "Canada Post"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    
    @IBAction func otherButtonTapped(sender: AnyObject) {
        deliveryCompany = "Other"
        performSegueWithIdentifier(deliverySelectedSegue, sender: self)
    }
    

    //
    // MARK: - Navigation
    //
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let deliveryMethodController = segue.destinationViewController as? DeliveryMethodViewController {
            deliveryMethodController.deliveryCompany = deliveryCompany
        }
    }
    
}
