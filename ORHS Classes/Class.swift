//
//  Class.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/4/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import Foundation

class Class {
    //MARK: Properties
    var name: String
    var subject: String
    var credits: String
    var GPA: String
    var hours: String
    var description: String
    var added: Bool
    
    //MARK: Initilizer
    init?(data: [String]) {
        if data.isEmpty {
            print("missing class data")
            return nil
        }
        self.name = data[0]
        self.subject = data[1]
        
        self.credits = data[2]
        self.GPA = data[3]
        self.hours = data[4]
        self.description = data[5]
        self.added = false
    }
}
