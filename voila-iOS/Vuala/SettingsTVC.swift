//
//  SettingsTVC.swift
//  Voilà
//
//  Created by Patrik Vaberer on 10/17/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func bLogout(sender: AnyObject) {
        
        h.isRegistered = false
        
        UIApplication.sharedApplication().delegate?.window??.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RegisterNav")
        
    }
}
