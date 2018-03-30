//
//  ForgotPassController.swift
//  MyApp
//
//  Created by Juan Andonaire on 3/26/18.
//  Copyright © 2018 Juan Andonaire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPassController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //HIDE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var remailTF: UITextField!    

    @IBAction func submit(_ sender: Any) {
        if emailTF.text == remailTF.text{
            Auth.auth().sendPasswordReset(withEmail: self.emailTF.text!, completion: {(error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "RESET FAILED", message: "\(String(describing: error?.localizedDescription))Text fields are empty", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                        self.emailTF.text = ""
                        self.remailTF.text = ""
                    }))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                    return
                    
                }else{
                    let resetEmailSentAlert = UIAlertController(title: "RESET EMAIL SENT", message: "A link to change your password has been sent to your registered email address successfully", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                        self.emailTF.text = ""
                        self.remailTF.text = ""
                        
                    }))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }else{
            let emailNotMatchAlert = UIAlertController(title: "OOPS!", message: "Emails do not match", preferredStyle: .alert)
            emailNotMatchAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:{(action) in
                self.emailTF.text = ""
                self.remailTF.text = ""
            }))
            present(emailNotMatchAlert, animated: true, completion: nil)
        }
    }
}
