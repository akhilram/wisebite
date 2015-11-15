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
    
    var context :AnyObject = [];
    
    @IBOutlet weak var table: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.context = context!
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.displayInfo(self.context);
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
//        let response: [String:String] = ["name":"Cheese", "calorie":"100kCal"]
//        self.pushControllerWithName("Report", context: response)
        let row = table.rowControllerAtIndex(rowIndex) as! ItemRowController
        print(row.ndbNo)
        getSearchResults(String(row.ndbNo))
    }
    
    
    func performNavigation(results: String) {
        do {
            let data = results.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            //print(data)
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) as AnyObject;
            
            self.pushControllerWithName("ReportMulti", context: jsonObject);
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                callback(result as String, nil)
            }
        }
        task.resume()
    }
    
    func getSearchResults(text: String) {
        
        //Try for cheese
        
        let url = "https://calorie-checker.azurewebsites.net/lookup?ndb=";
        let queryURL = url + text
        print(queryURL)
        
        let request = NSMutableURLRequest(URL: NSURL(string: queryURL)!)
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                self.performNavigation(data)
            }
        }

    }
}