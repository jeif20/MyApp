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
    
    //var userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //SIGNING IN
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
                notverifiedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(notverifiedAlert, animated: true, completion: nil)
                do{
                    try Auth.auth().signOut()
                } catch{
                    //handle error
                }
                
            }
        }
        
    }
    
    //FORGOT PASSWORD
    @IBAction func forgotpws(_ sender: Any) {
        let forgotpwsAlert = UIAlertController(title: "Forgot Password", message: "Enter your email address here", preferredStyle: .alert)
        forgotpwsAlert.addTextField{(textField) in
            textField.placeholder = "Enter your email address"
        }
        forgotpwsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotpwsAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: {(action) in
            let resetEmail = forgotpwsAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                    
                }else{
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent", message: "A password has been sent to your registered email address successfully", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
            
        }))
        
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
