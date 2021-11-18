//
//  ToDoListVCExtension.swift
//  ToDoList
//
//  Created by Ravi dwivedi on 27/10/21.
//  Copyright © 2021 Ravi dwivedi. All rights reserved.
//

import Foundation
import UIKit


extension ToDoListVC:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return toDoListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        cell.textLabel?.text = toDoListArr[indexPath.row].name
        let dateStr = toDoListArr[indexPath.row].createdAt?.string(format:"dd-MM-yyyy")
        cell.detailTextLabel?.text = dateStr
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = toDoListArr[indexPath.row]
        
        let sheet = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title:"Edit", style: .default, handler: {[weak self] _ in
            self?.openToListView(item: [item])
        }))
        sheet.addAction(UIAlertAction(title:"Delete", style: .destructive, handler: {[weak self] _ in
             self?.deleteItems(item: item)
        }))
        present(sheet, animated: true)
        
    }
    
    
    
    
}
