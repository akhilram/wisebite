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
    
//    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request){
//            (data, response, error) -> Void in
//            if error != nil {
//                callback("", error!.localizedDescription)
//            } else {
//                let result = NSString(data: data!, encoding:
//                    NSASCIIStringEncoding)!
//                callback(result as String, nil)
//            }
//        }
//        task.resume()
//    }
//    
//    func getSearchResults(text: String) {
//        //Try for cheese
//        let request = NSMutableURLRequest(URL: NSURL(string: "https://calorie-checker.azurewebsites.net/search?keywords[0]=cheese")!)
//        httpGet(request){
//            (data, error) -> Void in
//            if error != nil {
//                print(error)
//            } else {
//                print(data);
//                self.displayInfo(data);
//                
//            }
//        }
//    }
    
    func displayInfo(var results: AnyObject){
//       results = "[[{\"offset\":0,\"group\":\"Fats and Oils\",\"name\":\"Margarine-like, margarine-butter blend, soybean oil and butter\",\"ndbno\":\"04585\"},{\"offset\":1,\"group\":\"Legumes and Legume Products\",\"name\":\"Peanut butter, reduced sodium\",\"ndbno\":\"42291\"},{\"offset\":2,\"group\":\"Baked Products\",\"name\":\"Croissants, butter\",\"ndbno\":\"18239\"},{\"offset\":3,\"group\":\"Dairy and Egg Products\",\"name\":\"Butter, salted\",\"ndbno\":\"01001\"},{\"offset\":4,\"group\":\"Dairy and Egg Products\",\"name\":\"Butter, whipped, with salt\",\"ndbno\":\"01002\"},{\"offset\":5,\"group\":\"Dairy and Egg Products\",\"name\":\"Butter oil, anhydrous\",\"ndbno\":\"01003\"},{\"offset\":6,\"group\":\"Dairy and Egg Products\",\"name\":\"Butter, without salt\",\"ndbno\":\"01145\"},{\"offset\":7,\"group\":\"Fats and Oils\",\"name\":\"Oil, cocoa butter\",\"ndbno\":\"04501\"},{\"offset\":8,\"group\":\"Fats and Oils\",\"name\":\"Oil, nutmeg butter\",\"ndbno\":\"04572\"},{\"offset\":9,\"group\":\"Fats and Oils\",\"name\":\"Oil, ucuhuba butter\",\"ndbno\":\"04573\"},{\"offset\":10,\"group\":\"Nut and Seed Products\",\"name\":\"Seeds, sesame butter, paste\",\"ndbno\":\"12169\"},{\"offset\":11,\"group\":\"Sweets\",\"name\":\"Fruit butters, apple\",\"ndbno\":\"19294\"},{\"offset\":12,\"group\":\"Fats and Oils\",\"name\":\"Butter, light, stick, with salt\",\"ndbno\":\"04601\"},{\"offset\":13,\"group\":\"Fats and Oils\",\"name\":\"Butter, light, stick, without salt\",\"ndbno\":\"04602\"},{\"offset\":14,\"group\":\"Nut and Seed Products\",\"name\":\"Seeds, sunflower seed butter, without salt\",\"ndbno\":\"12040\"},{\"offset\":15,\"group\":\"Nut and Seed Products\",\"name\":\"Nuts, cashew butter, plain, without salt added\",\"ndbno\":\"12088\"},{\"offset\":16,\"group\":\"Nut and Seed Products\",\"name\":\"Nuts, almond butter, plain, without salt added\",\"ndbno\":\"12195\"},{\"offset\":17,\"group\":\"Nut and Seed Products\",\"name\":\"Seeds, sunflower seed butter, with salt added\",\"ndbno\":\"12540\"},{\"offset\":18,\"group\":\"Nut and Seed Products\",\"name\":\"Nuts, cashew butter, plain, with salt added\",\"ndbno\":\"12588\"},{\"offset\":19,\"group\":\"Nut and Seed Products\",\"name\":\"Nuts, almond butter, plain, with salt added\",\"ndbno\":\"12695\"}]]"
        
//        let data = results.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
//        
//        do {
//            let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [AnyObject]
//            if let json1 = json[0] as? [AnyObject]{
//                table.setNumberOfRows(json1.count, withRowType: "ItemCell")
//                var index = 0;
//                for anItem in json1 as! [Dictionary<String, AnyObject>] {
//                    print(anItem["name"]!)
//                    
//                    let controller = table.rowControllerAtIndex(index) as! ItemRowController
//                    controller.label.setText(anItem["name"] as? String)
//                    index += 1
//                }
//            }
//        } catch let error as NSError {
//            print("Failed to load: \(error.localizedDescription)")
//        }
        table.setNumberOfRows(results[0].count, withRowType: "ItemCell");
        var index = 0;
        for anItem in results[0] as! [Dictionary<String, AnyObject>] {
                                print(anItem["name"]!)
            
                                let controller = table.rowControllerAtIndex(index) as! ItemRowController
                                controller.label.setText(anItem["name"] as? String)
                                index += 1
                            }

        
        
    }
    
}