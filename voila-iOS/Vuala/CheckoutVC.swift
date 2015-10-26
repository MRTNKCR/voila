//
//  CheckoutVC.swift
//  Vuala
//
//  Created by Patrik Vaberer on 10/17/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import SVProgressHUD




class CheckoutVC: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var bSend: UIButton!
    @IBAction func bcheck(sender: AnyObject) {
        
        
        performSegueWithIdentifier("checkoutToAddress", sender: nil)
    }
    
    @IBOutlet weak var lTotalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!

    func recountPrice() {
        
        tableView.dataSource = self
        
        var s: Double = 0
        for p in h.items {
            
            let price = p.price ?? 1
            print(price, "price")
            print(p.amountOrdered)
            
            s += Double(p.amountOrdered) * price
        }
        
        lTotalPrice.text = String(format: "%.2f", s)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        recountPrice()
        
        
        tableView.tableFooterView = nil
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        
        
       
    }
    
    @IBAction func sendOrder(sender: AnyObject) {
        
        if h.items.count == 0 {
            
            H.showMessage("Prázdny košík")
            return
        }
        
        
        if h.canOrder() == false {
            H.showMessage("Prosím, zadejte všechny údaje")
            performSegueWithIdentifier("checkoutToAddress", sender: nil)
            
            return
        }
        
        
        let uid = h.userID
        print("USR IDL ", uid)
        SVProgressHUD.show()
        h.sendOrder(uid, items: h.items) { (success) -> Void in
            
            if success {
                
                h.syncAddress(uid, address: h.user.address, zip: h.user.zip, city: h.user.city) { (success) -> Void in
                    SVProgressHUD.dismiss()
                    
                        print("SUCESS     ", success)
                        h.items.removeAll()
                        self.tableView.reloadData()
                        self.lTotalPrice.text = "0.00"
                        H.showMessage("Výborně! Objednávka byla přijata")
                        H.showMessage("Uloženo")


                }
                
            } else {
                
                H.showMessage("Zkuste to znovu")
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return  h.items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let p = h.items[indexPath.row]
        let c = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductCell
        

        c.lPrice.text = String(format: "%.2f",  Double(p.amountOrdered) * p.price!) + " Kč"
        c.iProduct.image = p.image
        c.lName.text = String(p.amountOrdered) + " ks - " + p.name!
        
        c.bRemove.tag = indexPath.row
        c.bRemove.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        return c
        
        
    }
    
    func buttonClicked(sender:UIButton) {
        
        h.items.removeAtIndex(sender.tag)
        tableView.reloadData()
        recountPrice()
    }
}
