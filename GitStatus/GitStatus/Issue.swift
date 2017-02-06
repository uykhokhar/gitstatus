//
//  TableCell.swift
//  GitStatus
//
//  Created by MouseHouseApp on 2/4/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation
import UIKit

enum issueType : String {
    case open = "open"
    case closed = "closed"
}

// Attribution: https://www.natashatherobot.com/non-optional-uiimage-named-swift/
extension issueType {
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}

extension UIImage {
    convenience init(asset: issueType) {
        self.init(named: asset.rawValue)!
    }
}


class Issue {
    
    var issueTitle : String
    var gitUsername : String
    var issueDate : Date
    var type: issueType
    var url: String
    var body: String
    
    init(issueTitle: String, gitUsername: String, issueDate: Date, type : issueType, URL : String, body: String){
        self.issueTitle = issueTitle
        self.gitUsername = gitUsername
        self.issueDate = issueDate
        self.type = type
        self.url = URL
        self.body = body
    }
    
    
}


