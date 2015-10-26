//
//  ViewController.swift
//  Vuala
//
//  Created by Patrik Vaberer on 10/16/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import SVProgressHUD

class ViewController: UIViewController, ScannerDelegate {

    
    
    var canOpenProduct = true
    var product: Product?
    
    @IBOutlet weak var contr: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        canOpenProduct = true
    }


    func didFoundBarCode(code: String) {
        

        if canOpenProduct {
            
            SVProgressHUD.show()
            canOpenProduct = false
            h.getProduct(code, completion: { (found, product) -> Void in
                
                SVProgressHUD.dismiss()
                
                if found {
                
                    self.product = product
                    self.performSegueWithIdentifier("homeToProduct", sender: nil)
                } else {
                    
                                    self.product = nil
                    let alert = UIAlertController(title:"Zboží nebylo nalezeno", message: nil, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in
                        
                        self.canOpenProduct = true
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)

                }

                
            })
        }


//        print(code)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let c =  segue.destinationViewController as? ScannerVC {
            
            c.delegate = self
        } else if let c = segue.destinationViewController as? ProductVC {
            
            c.product = product
        }
    }

}

