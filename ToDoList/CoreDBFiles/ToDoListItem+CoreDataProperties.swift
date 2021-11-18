//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Ravi dwivedi on 27/10/21.
//  Copyright © 2021 Ravi dwivedi. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}
