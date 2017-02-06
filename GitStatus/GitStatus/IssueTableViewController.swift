//
//  IssueTableViewController.swift
//  GitStatus
//
//  Created by MouseHouseApp on 2/4/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class IssueTableViewController: UITableViewController {

    var issuesArray : [Issue] = []
    let urlStringOpen = "https://api.github.com/repos/uchicago-mobi/mpcs51030-2017-winter-forum/issues?state=open"
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Attribution: - worked with TA on getting data to load
        getDataFromURL(urlString: urlStringOpen) { (response) in
            self.tableView.reloadData()
        }
        
        // - Attribution: pull to refresh https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/
        self.refreshControl?.addTarget(self, action: #selector(IssueTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
                
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issuesArray.count
    }
    
    
    // Attribution: - https://thatthinginswift.com/completion-handlers/
    func getDataFromURL(urlString: String, completion: @escaping ([Issue]) -> Void){
        
        
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
                var tempIssuesArray : [Issue] = []
                
                for entry in issues {
                    let url = entry["html_url"] as? String
                    print("url: \(url)")
                    let title = entry["title"] as? String
                    let userDic = entry["user"] as? [String: Any]
                    let user = userDic?["login"] as? String
                    print("user: \(user)")
                    let type = self.issueStateConversion(state: (entry["state"] as? String))
                    let body = entry["body"] as? String
                    
                    let tempIssue = Issue(issueTitle: title!, gitUsername: user!, issueDate: "TEST DATE", type: type, URL: url!, body: body!)
                    tempIssuesArray.append(tempIssue)
                }
                
                self.issuesArray = tempIssuesArray
                
                completion(self.issuesArray)
                
                
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
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as! IssueTableViewCell
        

        cell.date.text = issuesArray[indexPath.row].issueDate
        cell.title.text = issuesArray[indexPath.row].issueTitle
        cell.username.text = issuesArray[indexPath.row].gitUsername
        cell.imageView?.image = UIImage(named: "open")
        
        return cell
        
    }
    
    // Pull to refresh
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        getDataFromURL(urlString: urlStringOpen) { (response) in
            self.tableView.reloadData()
        }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

    
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //navigationItem.title = nil
        
        if segue.identifier == "toDetail" {

            let destinationController = segue.destination as! DetailViewController
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let selectedIssue = issuesArray[indexPath.row]
                    destinationController.issueDetail = selectedIssue
                    
                }
        }
    }
    
    @IBAction func returnFromDetails(segue:UIStoryboardSegue) {
    }
    
    
    

    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
