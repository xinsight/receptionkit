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
        otherButton.setTitle(Text.get("other"), for: UIControlState())
        
        // Make sure that the button images are not skewed
        upsButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        fedExButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        canadaPostButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    
    //
    // Delivery company button taps
    //
    
    @IBAction func upsButtonTapped(_ sender: AnyObject) {
        deliveryCompany = "UPS"
        performSegue(withIdentifier: deliverySelectedSegue, sender: self)
    }
    
    @IBAction func fedExButtonTapped(_ sender: AnyObject) {
        deliveryCompany = "FedEx"
        performSegue(withIdentifier: deliverySelectedSegue, sender: self)
    }
    
    @IBAction func canadaPostButtonTapped(_ sender: AnyObject) {
        deliveryCompany = "Canada Post"
        performSegue(withIdentifier: deliverySelectedSegue, sender: self)
    }
    
    @IBAction func otherButtonTapped(_ sender: AnyObject) {
        deliveryCompany = "Other"
        performSegue(withIdentifier: deliverySelectedSegue, sender: self)
    }
    

    //
    // MARK: - Navigation
    //
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let deliveryMethodController = segue.destination as? DeliveryMethodViewController {
            deliveryMethodController.deliveryCompany = deliveryCompany
        }
    }
    
}
