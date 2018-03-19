//
//  RegisterController.swift
//  MyApp
//
//  Created by Juan Andonaire on 3/18/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var epasswordTF: UITextField!
    
    
    @IBAction func signup(_ sender: Any) {
        if epasswordTF.text == passwordTF.text{
            Auth.auth().createUser(withEmail: self.emailTF.text!, password: self.passwordTF.text!) {(user, error) in
                if error != nil {
                    let signuperrorAlert = UIAlertController(title: "SignUp error", message: "\(String(describing: error?.localizedDescription)) Please try again later", preferredStyle: .alert)
                    signuperrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(signuperrorAlert, animated: true, completion: nil)
                    return
                }
                
                self.sendEmail()
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            let pswNotMatchAlert = UIAlertController(title: "Oops", message: "Password do not match", preferredStyle: .alert)
            pswNotMatchAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:{(action) in
                self.passwordTF.text = ""
                self.epasswordTF.text = ""
            }))
            present(pswNotMatchAlert, animated: true, completion: nil)
        }
    }
    
    func sendEmail(){
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) {(user, error) in
            if error != nil{
                print("Error: \(String(describing:error!.localizedDescription))")
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification(completion: {(error) in
                if error != nil{
                    let emailNOTSentAlert = UIAlertController(title: "Email Verification", message: "Verification email failed to send \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    emailNOTSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailNOTSentAlert, animated: true, completion: nil)
                }else{
                    let emailSentAlert = UIAlertController(title: "Email Verification", message: "Verification email has been sent", preferredStyle: .alert)
                    emailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailSentAlert, animated: true, completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                do{
                    try Auth.auth().signOut()
                }
                catch{
                    //ERROR HANDLING
                }
                
                
            })
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool{
            if textField == emailTF{
                passwordTF.becomeFirstResponder()
                
            }else if textField == passwordTF{
                epasswordTF.becomeFirstResponder()
            }else{
                textField.resignFirstResponder()
            }
            return true
        }
        
        
        
    }
    }
    
