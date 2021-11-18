//
//  AlertVC.swift
//  ToDoList
//
//  Created by Ravi dwivedi on 27/10/21.
//  Copyright © 2021 Ravi dwivedi. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func showAlert(alertMessage:String)
    {
    
       let alert = UIAlertController.init(title:"Alert!", message: alertMessage, preferredStyle: .alert)
        let ok = UIAlertAction.init(title:"OK", style: .default) { (ok) in
            print("\(ok)")
        }
        alert.addAction(ok)
        self.present(alert, animated: false, completion: nil)
    }
    

  

}
