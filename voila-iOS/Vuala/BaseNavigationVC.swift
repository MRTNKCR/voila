//
//  BaseNavigationVC.swift
//  Wipe
//
//  Created by Patrik Vaberer on 10/2/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit


class BaseNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.whiteColor()
    ]

    
        navigationBar.barTintColor = UIColor(red: 245/255.0, green: 65/255.0, blue: 55/255.0, alpha: 1)
        

        
    }


    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if visibleViewController != nil {
            // might be nil if we create new controller using initWithRootViewController initializer
            visibleViewController!.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        }
        super.pushViewController(viewController, animated: animated)
    }
}
