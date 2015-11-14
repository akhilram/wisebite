//
//  InterfaceController.swift
//  WiseBiteSwift WatchKit Extension
//
//  Created by Arjun Pola on 14/11/15.
//  Copyright © 2015 USC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
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
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        if(segueIdentifier == "search")
        {
            
        }
        
        return self
    }
    
    @IBAction func speak() {
        
        self.pushControllerWithName("Search", context: "Passed through hierarchical navigation");
    
//        self.presentTextInputControllerWithSuggestions(nil, allowedInputMode: .Plain, completion: { (answers) -> Void in
//            if (answers != nil) {
//                if(answers!.count > 0){
//                    if let answer = answers![0] as? String {
//                        print(answer)
//                        let ansArray = answer.characters.split{$0 == " "}.map(String.init);
//                        
//                        if(ansArray.count == 1)
//                        {
//                            
//                            self.pushControllerWithName("Search", context: ["segue":"asdf"]);
//                        }
//                        else
//                        {
//                            
//                        }
//                    }
//                    
//                    
//                }
//            }
//        })
    }

}
