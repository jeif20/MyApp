//
//  SigninController.swift
//  MyApp
//
//  Created by Juan Andonaire on 3/18/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SigninController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signin(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!) {(user, error) in
            if error != nil {
                let loginerrorAlert = UIAlertController(title: "Login error", message: "\(String(describing: error?.localizedDescription)) Please try again", preferredStyle: .alert)
                loginerrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(loginerrorAlert, animated: true, completion: nil)
                return
                
            }
            if user!.isEmailVerified{
                //take user to firebase realtime database
                self.performSegue(withIdentifier: "loggedin", sender: self)
            }else{
                let notverifiedAlert = UIAlertController(title: "Not verified", message: "Please verify your account", preferredStyle: .alert)
                
                
                
            }
        }
        
        
    }
    
}
