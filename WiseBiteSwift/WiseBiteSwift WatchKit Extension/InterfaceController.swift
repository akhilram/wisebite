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
    
    @IBAction func speak() {
    
        self.presentTextInputControllerWithSuggestions(nil, allowedInputMode: .Plain, completion: { (answers) -> Void in
            if (answers != nil) {
                if(answers!.count > 0){
                    if let answer = answers![0] as? String {
                        self.getSearchResults(answer)
                    }
                }
            }
            else{
                print("Not a valid query")
                
            }
        })
    }
    
    func performNavigation(results: String) {
        do {
            let data = results.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            //print(data)
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) as AnyObject;
            
            if let json = jsonObject["type"] as? String{
                if json == "search" {
                    self.pushControllerWithName("Search", context: jsonObject["results"]);
                }
                else if json == "report"{
                    self.pushControllerWithName("ReportMulti", context: jsonObject["results"]);
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func getSearchResults(text: String) {
       
        //Try for cheese
        
        var finalEscapedQuery = ""
        let url = "https://calorie-checker.azurewebsites.net/search?keywords=";
        
        let words = text.characters.split{$0 == " "}.map(String.init)
        
        for(var i = 0; i < words.count; i++){
            if i != 0 {
                finalEscapedQuery = finalEscapedQuery + "%20" + words[i].stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            }
            else{
                finalEscapedQuery = words[i]
            }
        }
        
        
        let queryURL = url + finalEscapedQuery
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

}
