//
//  ScannerVC.swift
//  Vuala
//
//  Created by Patrik Vaberer on 10/16/15.
//  Copyright © 2015 Patrik Vaberer. All rights reserved.
//

import UIKit
import RSBarcodes_Swift

protocol ScannerDelegate {
    
    func didFoundBarCode(code: String)
}


class ScannerVC: RSCodeReaderViewController {
    
    var delegate: ScannerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        
        self.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
        
        self.tapHandler = { point in
            print(point)
        }
        
        self.barcodesHandler = { barcodes in
            for barcode in barcodes {
                print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                
                
                dispatch_async(dispatch_get_main_queue()) {

                    self.delegate?.didFoundBarCode(barcode.stringValue)

                }
            }
        }
        
    }
    
    
    
}
