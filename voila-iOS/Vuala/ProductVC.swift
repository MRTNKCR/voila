//
//  ProductVC.swift
//
//
//  Created by Patrik Vaberer on 10/16/15.
//
//

import UIKit

class ProductVC: UIViewController {
    
    
    @IBOutlet weak var bAddNext: UIButton!
    @IBOutlet weak var lNumber: UILabel!
    @IBOutlet weak var lDescription: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var lPrice: UILabel!
    @IBOutlet weak var iProduct: UIImageView!
    
    
    
    var product: Product!
    var numberOfGoods = 1 {
        
        didSet {
            
            if numberOfGoods < 1 {
                
               return
            }
            
            if oldValue > numberOfGoods {
                
                product.amountOrdered--
            } else {
                
                product.amountOrdered++
            }
            print(product.amountOrdered)
            lNumber.text = "\(numberOfGoods)"
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lNumber.text = "\(numberOfGoods)"
        iProduct.image = product.image
        lName.text = product.name
        lDescription.text = product.desc
        

        lPrice.text = "Cena: " + String(format: "%.2f",  product.price!) + " Kč"
        
        
        
    }
    
    @IBAction func minus(sender: AnyObject) {
        
        numberOfGoods--
        
    }
    
    
    @IBAction func plus(sender: AnyObject) {
        
        
        numberOfGoods++
        
    }
    
    
    @IBAction func bAddNext(sender: UIButton) {
        
        H.showMessage("Zboží přidáno")
        h.items.append(product)
        navigationController?.popViewControllerAnimated(true)
        
    }
}
