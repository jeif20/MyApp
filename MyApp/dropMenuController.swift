//
//  dropMenuController.swift
//  MyApp
//
//  Created by Juan Andonaire on 4/4/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import UIKit
import Firebase

class dropMenuController: UIViewController {

   
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var sensorButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //LOG OUT
    @IBAction func signin(_ sender: Any) {
        self.performSegue(withIdentifier: "loggedout", sender: self)
        let logoutAlert = UIAlertController(title: "LOG OUT", message: "You have logged out successuflly", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
    
        }))
    self.present(logoutAlert, animated: true, completion: nil)
    do{
    try Auth.auth().signOut()
    } catch{
    //handle error
    }
  }
    
    
    @IBAction func handleSelection(_ sender: UIButton) {
        sensorButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                self.textView.isHidden = true//fix this line of code
                
            })
        }
    }
    
    
    
}
