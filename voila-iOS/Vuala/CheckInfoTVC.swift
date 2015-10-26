//
//  CheckInfoTVC.swift
//  Voilà
//
//  Created by Patrik Vaberer on 10/17/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import SVProgressHUD

class CheckInfoVC: UIViewController {
    
    
    @IBOutlet weak var fEmail: UITextField!
    
    @IBOutlet weak var fName: UITextField!
    
    @IBOutlet weak var fAddress: UITextField!
    
    @IBOutlet weak var fCity: UITextField!
    
    @IBOutlet weak var fZIP: UITextField!
    
    
    
    
    @IBOutlet weak var bSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fName.text = h.user.name
        fEmail.text = h.user.email
        
        fAddress.text = h.user.address
        fZIP.text = h.user.zip
        fCity.text = h.user.city
        fName.becomeFirstResponder()
        
        
        
        
        
    }
    
    @IBAction func vAcceptPressed(sender: AnyObject) {
        
        view.endEditing(true)
        h.user.name = fName.text!
        h.user.email = fEmail.text!
        
        h.user.address = fAddress.text!
        h.user.zip = fZIP.text!
        h.user.city = fCity.text!
        
        self.dismissViewControllerAnimated(true, completion: nil)

        
    }
}
