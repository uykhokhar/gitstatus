//
//  SecondViewController.swift
//  GitStatus
//
//  Created by MouseHouseApp on 2/4/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    
    var countIssues : (open: Int, closed: Int) = (open: 0, closed: 0)
    
    let urlStringAll = "https://api.github.com/repos/uchicago-mobi/mpcs51030-2017-winter-forum/issues?state=all"
    

    @IBOutlet weak var numOpenIssues: UILabel!
    
    @IBOutlet weak var numClosedIssues: UILabel!
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getCountOfIssues(urlString: urlStringAll) { (response) in
            self.numOpenIssues.text = String(self.countIssues.open)
            self.numClosedIssues.text = String(self.countIssues.closed)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data processing
    
    func getCountOfIssues(urlString: String, completion: @escaping ((open: Int, closed: Int)) -> Void){
        
        
        guard let url = NSURL(string: urlString) else {
            fatalError("Unable to create NSURL from string")
        }
        
        // Create a vanilla url session
        let session = URLSession.shared
        
        // Create a data task
        let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            
            // Print out the response
            print("Response: \(response)")
            
            // Ensure there were no errors returned from the request
            guard error == nil else {
                print("error: \(error!.localizedDescription)")
                fatalError("Error: \(error!.localizedDescription)")
            }
            
            // Ensure there is data and unwrap it
            guard let data = data else {
                fatalError("Data is nil")
            }
            
            // We received data but it needs to be processed
            print("Raw data: \(data)")
            
            // Serialize the raw data into JSON using `NSJSONSerialization`.  The "do-try" is
            // part of an error handling feature of Swift that will be disccused in the future.
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                
                // Cast JSON as an array of dictionaries
                guard let issues = json as? [[String: AnyObject]] else {
                    fatalError("We couldn't cast the JSON to an array of dictionaries")
                }
                
                // Parse the array of dictionaries to get the important information that you
                // need to present to the user
                
                // Do some parsing here
                
                print("*****        BEGIN PARSING     ********")
                var tempCount : (open: Int, closed: Int) = (open: 0, closed: 0)
                
                for entry in issues {
                    let typeIssue = self.issueStateConversion(state: (entry["state"] as? String))

                    switch typeIssue {
                    case .open:
                        tempCount.open = tempCount.open + 1
                    case .closed:
                        tempCount.closed = tempCount.closed + 1
                        
                    }
                }
                
                print("open: \(String(tempCount.open)), closed: \(String(tempCount.closed))")
                
                self.countIssues = tempCount
                
                completion(self.countIssues)
                
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        })
        
        // Tasks start off in suspended state, we need to kick it off
        task.resume()
    }
    
    func issueStateConversion(state: String?) -> issueType {
        
        var returnType : issueType = issueType.open
        
        if let stateType = state {
            switch stateType {
                
            case "open":
                returnType = issueType.open
            case "closed":
                returnType = issueType.closed
            default:
                returnType = issueType.open
            }
        }
        
        return returnType
    }
    

    
    
}
