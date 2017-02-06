//
//  DetailViewController.swift
//  GitStatus
//
//  Created by MouseHouseApp on 2/5/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // - Mark: IBOutlets and IBActions
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var issueTypeImage: UIImageView!
    var issueDetail : Issue?

    
    // - Mark: variables
    
    var urlString: String?

    
    // - Mark: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = issueDetail?.issueTitle
        dateLabel.text = issueDetail?.issueDate
        usernameLabel.text = issueDetail?.gitUsername
        bodyLabel.text = "Body of the issue"
        urlString = issueDetail?.url
        
        
        // change issue image to image of issue
        issueTypeImage.image = UIImage(named: "open")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBActions
    
    @IBAction func openLink(_ sender: Any) {
        if let url = NSURL(string: urlString!){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
