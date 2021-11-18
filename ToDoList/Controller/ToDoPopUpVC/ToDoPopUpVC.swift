//
//  ToDoPopUpVC.swift
//  ToDoList
//
//  Created by Ravi dwivedi on 27/10/21.
//  Copyright © 2021 Ravi dwivedi. All rights reserved.
//

import UIKit
import CoreData
protocol ToDoList: class
{
   func createdToDoList(name:String, createdDate:Date)
   func updateToDoList(item:[ToDoListItem],name:String,createdDate:Date)

}


class ToDoPopUpVC: UIViewController {
    
    @IBOutlet weak var nameTxtField:UITextField!
    @IBOutlet weak var createdTxtField:UITextField!
    weak var delegateToDoList:ToDoList?
   
    var item:[ToDoListItem] = []
    var editingData = false
    var datePicker:UIDatePicker = UIDatePicker()
    var index:Int = Int()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Gesture to the view to dismissing
        let gesture = UITapGestureRecognizer.init(target:self , action: #selector(dissmissPopUpView))
        self.view.addGestureRecognizer(gesture)
        createDatePicker()
        
        if (item.count>0) {
            nameTxtField.text = item[index].name
            createdTxtField.text = item[index].createdAt?.string(format:"dd-MM-yyyy")
        }
        
       
    }
    
    func createDatePicker()
    {
        //Tool Bar creation
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // Done Button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target:nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        createdTxtField.inputAccessoryView = toolBar
        createdTxtField.inputView = datePicker
        //DatePicker mode
        datePicker.datePickerMode = .date
    }
    
    @objc func doneButtonPressed()
    {
        //DateFormatter
        let formattter = DateFormatter()
        formattter.dateStyle = .medium
        formattter.timeStyle = .none
        createdTxtField.text = formattter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @objc func dissmissPopUpView()
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func AddItemIntoToList(_ sender: Any) {
        
        if nameTxtField.text!.isEmpty {
            let alert = UIAlertController.init(title:"Alert!", message:" To Do Name can't be an empty", preferredStyle: .alert)
            let ok =  UIAlertAction.init(title:"OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: false, completion: nil)
            return
        }
       
        if createdTxtField.text!.isEmpty {
            let alert = UIAlertController.init(title:"Alert!", message:" Created Date can't be an empty", preferredStyle: .alert)
            let ok =  UIAlertAction.init(title:"OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: false, completion: nil)
            return
        }
        
        guard let delegate = self.delegateToDoList else { return }
        //Date formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
       if editingData{
       
        if let date = formatter.date(from:createdTxtField.text!)
        {
             delegate.updateToDoList(item:item, name: nameTxtField.text!, createdDate: date)
        }
        
       }
        else
        {
           
            delegate.createdToDoList(name: nameTxtField.text!, createdDate: formatter.date(from:createdTxtField.text!)!)
        }
        self.dissmissPopUpView()
    }
    
}

