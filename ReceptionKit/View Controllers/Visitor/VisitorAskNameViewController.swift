//
//  VisitorAskNameViewController.swift
//  ReceptionKit
//
//  Created by Andy Cho on 2015-04-23.
//  Copyright (c) 2015 Andy Cho. All rights reserved.
//

import UIKit

class VisitorAskNameViewController: ReturnToHomeViewController, UITextFieldDelegate {
    
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    let visitorEnteredNameSegue = "VisitorEnteredNameSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.roundedRect
        yourNameLabel.text = Text.get("your name")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Not doing this in viewDidLoad() as that raises the keyboard before the segue
        nameTextField.becomeFirstResponder()
    }
    
    
    //
    // MARK: - UITextViewDelegate
    //
    
    // Segue to the VisitorViewController when the name is entered
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: visitorEnteredNameSegue, sender: self)
        return false
    }
    
    
    //
    // MARK: - Navigation
    //
    
    // Set the visitor's name before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let visitorViewController = segue.destination as? VisitorViewController {
            visitorViewController.visitorName = nameTextField.text
        }
        
    }
    
}
