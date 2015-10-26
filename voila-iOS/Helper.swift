//
//  Helper.swift
//  Vuala
//
//  Created by Patrik Vaberer on 10/16/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import PVShow_Message





struct User {
    
    
    
    
    var email: String {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().stringForKey("email") ?? ""
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "email")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var name: String {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().stringForKey("name") ?? ""
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "name")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var address: String {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().stringForKey("address") ?? ""
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "address")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
    
    var zip: String {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().stringForKey("zip") ?? ""
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "zip")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    var city: String {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().stringForKey("city") ?? ""
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "city")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}

struct Product {
    
    var id: String
    var name: String?
    var desc: String?
    var image: UIImage?
    var price: Double?
    var bar: String
    var amountOrdered: Int
}

let h = H()
class H {
    
    var canSendImmediatelly = false
    
    
    func canOrder() -> Bool {
        
        if user.name != "" && user.email != "" && user.zip != "" && user.address != "" && user.city != "" {
            
            return true
        }
        
        return false
    }
    
    var user = User()
    var items = [Product]()
    
    var userID: String {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().stringForKey("uID") ?? "test"
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "uID")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    var isRegistered: Bool {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().boolForKey("reg")
            
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "reg")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    static func showMessage(message: String) {
        
        PVShowMessage.cInitialPosition = .Top
        PVShowMessage.cPositionFromEdge = 80
        PVShowMessage.cBackgroundColor = UIColor(red: 245/255.0, green: 65/255.0, blue: 55/255.0, alpha: 1)
        PVShowMessage.instance.removeAllMessages()
        PVShowMessage.instance.showMessage(text: message)
    }
    
    
    
    
    
    func getProduct(code: String, completion: (found: Bool, product: Product?) -> Void) {
        
        Alamofire.request(.GET, "http://voila-nodejs-production.elasticbeanstalk.com/api/products", parameters: ["ean": code])
            .response { request, response, data, error in
                
                print(request)
                print(response)
                print(data)
                print(error)
                
                if response?.statusCode == 400 {
                    
                    completion(found: false, product: nil)
                    return
                }
                
                
                if let _ = error {
                    
                    completion(found: false, product: nil)
                    return
                }
                
                guard let data = data  else {
                    
                    completion(found: false, product: nil)
                    return
                }
                
                
                let json = JSON(data: data)
                print(json)
                
                if json["statusCode"] != nil {
                    
                    
                    completion(found: false, product: nil)
                    return
                }
                
                
                
                guard let idPrduct = json["id"].string else {
                    
                    completion(found: false, product: nil)
                    return
                }
                
                let url = NSURL(string: json["photo"].stringValue) ?? NSURL()
                
                let dataImage = NSData(contentsOfURL: url) ?? NSData()
                
                let image = UIImage(data:  dataImage)
                
                
                let price = (json["price"].stringValue as NSString).doubleValue
                let p = Product(id: String(idPrduct), name: json["name"].string, desc: json["category_name"].string, image: image, price: price, bar: code, amountOrdered: 1)
                
                
                completion(found: true, product: p)
                
        }
        
        
        
    }
    
    
    
    
    func register(email: String,name: String, pass: String, completion: (success: Bool) -> Void) {
        
        Alamofire.request(.POST, "http://voila-nodejs-production.elasticbeanstalk.com/api/signup", parameters: ["name": name, "email": email, "password": pass])
            .response { request, response, data, error in
                
                print(request)
                print(response)
                print(data)
                print(error)
                
                
                if response?.statusCode == 400 {
                    
                    h.userID = "userID"
                    
                    
                    h.user.name = "Martin"
                    h.user.email = "martin@strv.com"
                    completion(success: true)
                    return
                }
                
                
                if let _ = error {
                    
                    completion(success: false)
                    return
                }
                
                guard let data = data  else {
                    
                    completion(success: false)
                    return
                }
                
                
                let json = JSON(data: data)
                print(json)
                
                guard let uID = json["id"].string else {
                    
                    completion(success: false)
                    return
                }
                h.userID = uID

                
                h.user.name = name
                h.user.email = email

                
                completion(success: true)
                
        }
        
        
        
    }
    
    
    
    func priceFormat(price: Double) -> String {
        
        let f = NSNumberFormatter()
        f.numberStyle = .CurrencyStyle
        f.locale = NSLocale(localeIdentifier: "cz_CZ")
        return f.stringFromNumber(price)!
    }
    
    
    
    func sendOrder(userID: String, items: [Product], completion: (success: Bool) -> Void) {
        
        
        
        var toServer = [[String: AnyObject]]()
        
        
        for p in h.items {
            
            toServer.append(["id": p.id, "amount": p.amountOrdered])
        }
        
        print(toServer)
        print("user id", userID)
        
        Alamofire.request(.POST, "http://voila-nodejs-production.elasticbeanstalk.com/api/carts", parameters: ["userId": userID, "items": toServer])
            .response { request, response, data, error in
                
                print(request)
                print(response)
                print(data)
                print(error)
                
                
                
                
                
                if let _ = error {
                    
                    completion(success: false)
                    return
                }
                
                guard let data = data  else {
                    
                    completion(success: false)
                    return
                }
                
                
                let json = JSON(data: data)
                print(json)
                
                
                h.userID = json["id"].stringValue

                completion(success: true)
                
        }
        
        
        
    }
    
    
    
    func syncAddress(userID: String, address: String, zip: String, city: String, completion: (success: Bool) -> Void) {
        

        
        Alamofire.request(.POST, "http://voila-nodejs-production.elasticbeanstalk.com/api/transactions", parameters: ["userId": userID, "street": address, "city": city, "zipCode": zip])
            .response { request, response, data, error in
                
                print(request)
                print(response)
                print(data)
                print(error)
                
                
                if response?.statusCode == 400 {
                    
                    
                    completion(success: false)
                    return
                }
                
                if let _ = error {
                    
                    completion(success: false)
                    return
                }
                completion(success: true)
                
        }
        
        
        
    }
    
}