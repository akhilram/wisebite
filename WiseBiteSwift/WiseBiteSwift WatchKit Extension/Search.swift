//
//  Search.swift
//  WiseBiteSwift
//
//  Created by Arjun Pola on 14/11/15.
//  Copyright © 2015 USC. All rights reserved.
//

import WatchKit
import Foundation

class Search: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
//        self.getSearchResults("cheese");
//        if let text = context as? String{
////            
//            getSearchResults(text);
////            displayInfo("")
//        }
        self.displayInfo(context!);
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func displayInfo(results: AnyObject){
        
        table.setNumberOfRows(results[0].count, withRowType: "ItemCell");
        var index = 0;
        for anItem in results[0] as! [Dictionary<String, AnyObject>] {
                                //print(anItem["name"]!)
            
                                let controller = table.rowControllerAtIndex(index) as! ItemRowController
                                controller.label.setText(anItem["name"] as? String)
                                controller.ndbNo = anItem["ndbno"] as! String
            
                                index += 1
                            }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        //TODO: Display Animation
        //TODO: Call API
        //TODO: Present Report
        let response: [String:String] = ["name":"Cheese", "calorie":"100kCal"]
        self.pushControllerWithName("Report", context: response)
    }
}