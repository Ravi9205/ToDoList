//
//  DateFormatter.swift
//  ToDoList
//
//  Created by Ravi dwivedi on 28/10/21.
//  Copyright © 2021 Ravi dwivedi. All rights reserved.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func covertStringIntoDate(formate:String)->Date
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return  formatter.date(from:formate) ?? Date()
    
    }
}
