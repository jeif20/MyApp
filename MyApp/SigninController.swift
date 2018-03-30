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


class SigninController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //SIGNING IN
    @IBAction func signin(_ sender: Any) {
        
       Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!) {(user, error) in
            if error != nil {
                let loginerrorAlert = UIAlertController(title: "LOGIN ERROR", message: "\(String(describing: error?.localizedDescription)) Please try again", preferredStyle: .alert)
                loginerrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                    self.emailTF.text = ""
                    self.passwordTF.text = ""
                    
                }))
                self.present(loginerrorAlert, animated: true, completion: nil)
                return
                
            }
            if user!.isEmailVerified{
                //take user to firebase realtime database
                self.performSegue(withIdentifier: "loggedin", sender: self)
            }else{
                let notverifiedAlert = UIAlertController(title: "ALERT", message: "Email needs to be verified before signing in", preferredStyle: .alert)
                notverifiedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                    self.passwordTF.text = ""
                    
                }))
                self.present(notverifiedAlert, animated: true, completion: nil)
                do{
                    try Auth.auth().signOut()
                } catch{
                    //handle error
                }
                
            }
        }
      
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
}
