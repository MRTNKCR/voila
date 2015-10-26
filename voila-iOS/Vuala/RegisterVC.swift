//
//  RegisterVC.swift
//  Vuala
//
//  Created by Patrik Vaberer on 10/17/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterVC: UIViewController {

    
    
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var fPassword: UITextField!
    @IBOutlet weak var fEmail: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        
    }
    
    
    @IBAction func fRegister(sender: AnyObject) {
        
        
        if fPassword.text?.characters.count < 7 {
            
            H.showMessage("Heslo je krátké")
            return
        }
        
        SVProgressHUD.show()
        h.register(fEmail.text!, name: fName.text!, pass: fPassword.text!) { (success) -> Void in
            
            SVProgressHUD.dismiss()
            if success {
                
                self.performSegueWithIdentifier("registerToHome", sender: nil)
                h.isRegistered = true
                H.showMessage("Mužete začít nakupovat")
                
            } else {
                
                H.showMessage("Uživatel už existuje")
            }
        }
    }
}
