//
//  TableCell.swift
//  GitStatus
//
//  Created by MouseHouseApp on 2/4/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

enum issueType {
    case open
    case closed
}

class Issue {
    
    var issueTitle : String
    var gitUsername : String
    var issueDate : String
    var type: issueType
    var url: String
    
    init(issueTitle: String, gitUsername: String, issueDate: String, type : issueType, URL : String){
        self.issueTitle = issueTitle
        self.gitUsername = gitUsername
        self.issueDate = issueDate
        self.type = type
        self.url = URL
    }
    
    
}


