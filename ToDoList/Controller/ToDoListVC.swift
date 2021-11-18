//
//  ToDoListVC.swift
//  ToDoList
//
//  Created by Ravi dwivedi on 27/10/21.
//  Copyright © 2021 Ravi dwivedi. All rights reserved.
//

import UIKit

class ToDoListVC: UIViewController, ToDoList {
   
    

    @IBOutlet weak var tableView:UITableView!
    
    var context = CoreDataManager.shared.persistentContainer.viewContext
    
    var toDoListArr:[ToDoListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "ToDo List"
        tableView.tableFooterView = UIView()
        getAllitems()
    }
   
    func openToListView(item:[ToDoListItem])
    {
        guard let objTodoPopUp = self.storyboard?.instantiateViewController(withIdentifier:"ToDoPopUpVC") as? ToDoPopUpVC else { return }
        if item.count > 0 {
            objTodoPopUp.item = item
            objTodoPopUp.editingData = true
        }
        objTodoPopUp.delegateToDoList = self
        self.navigationController?.present(objTodoPopUp, animated: false, completion: nil)
        
    }
    
    
    @IBAction func addItemTapped(_ sender: Any) {
       openToListView(item: [])
    }
    
    //MARK:- CustomDelegate Create To Do List
    func createdToDoList(name:String, createdDate:Date)
    {
        toDoListArr.removeAll()
        self.createItems(name:name, date: createdDate)
    }
    
    //MARK:- Custom Delegate to upadte core data records
    func updateToDoList(item:[ToDoListItem],name:String,createdDate:Date)
    {
        toDoListArr.removeAll()
        self.updateItem(item: item[0], reName: name, date: createdDate)
    }

    
    
    func getAllitems()
    {
        toDoListArr.removeAll()
        do {
           let items =  try  context.fetch(ToDoListItem.fetchRequest()) as! [ToDoListItem]
            items.forEach { (item) in
              toDoListArr.append(item)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func createItems(name:String,date:Date)
    {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = date
        do {
            try context.save()
            getAllitems()

        } catch let error {
            print("error while saving data \(error.localizedDescription)")
        }
    }
    
    func deleteItems(item:ToDoListItem)
    {
        context.delete(item)
        do {
            try context.save()
            getAllitems()

            
        } catch let error {
            print("error while deleting  data from the data base \(error.localizedDescription)")
        }
    }
    
    func updateItem(item:ToDoListItem,reName:String,date:Date)
    {
        item.name = reName
        item.createdAt = date
        do {
            try context.save()
            getAllitems()

        } catch let error {
            print("error while updating  data in the data base \(error.localizedDescription)")
        }
    }

}
