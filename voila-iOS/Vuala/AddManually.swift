//
//  AddManually.swift
//  Vuala
//
//  Created by Patrik Vaberer on 10/16/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddManually: UIViewController {

    var product: Product?

    
    @IBOutlet weak var fCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        fCode.becomeFirstResponder()
    }
    
    
    @IBAction func bAddPressed(sender: UIButton) {
        
        
        SVProgressHUD.show()
        h.getProduct(fCode.text!, completion: { (found, product) -> Void in
            
            SVProgressHUD.dismiss()
            
            if found {
                
                self.product = product


                self.performSegueWithIdentifier("manuallyToProduct", sender: nil)
            } else {
                
                
                self.product = nil
                
                let alert = UIAlertController(title:"Zboží nebylo nalezeno", message: nil, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in
                    
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
         if let c = segue.destinationViewController as? ProductVC {
            
            c.product = product
        }
    }
    
}



