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
    
    var contents: [Int:String] = [
        208:"Calorie",
        203:"Protein",
        204:"Total Fat",
        291:"Total Fiber",
        205:"Carbohydrates",
        269:"Total Sugar"
    ]
    
    var totals: [Int:Int] = [
        208:0,
        203:0,
        204:0,
        291:0,
        205:0,
        269:0
    ]
    
    override func awakeWithContext(context: AnyObject?) {
//        if let report = context as? [AnyObject]{
//            
//            for item in report as! [Dictionary<String, AnyObject>]
//            {
//                //print(item["report"]!["food"]!!["name"]!)
//                for nutrients in item["report"]!["food"]!!["nutrients"] as! [AnyObject]{
//                    
//                    if let id = (nutrients["nutrient_id"] as? Int){
//                        if totals[id] != nil {
//                            totals[id] = totals[id]! + (nutrients["value"] as! Int)
//                        }
//                    }
//                }
//            }
//            
//            print(totals)
//            
//        }
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