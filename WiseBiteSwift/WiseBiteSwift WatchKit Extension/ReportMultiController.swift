//
//  ReportMultiController.swift
//  WiseBiteSwift
//
//  Created by Arjun Pola on 14/11/15.
//  Copyright © 2015 USC. All rights reserved.
//

import WatchKit
import Foundation

class ReportMultiController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        if let report = context as? [String:String]{
//            print(report["name"], report["calorie"])
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}