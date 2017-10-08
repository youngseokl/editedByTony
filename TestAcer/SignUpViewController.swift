//
//  SignUpViewController.swift
//  TestAcer
//
//  Created by Charles You on 2017-04-20.
//  Copyright © 2017 Charles You. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // User's name.
    @IBOutlet weak var nameField: UITextField!
    
    // User's email.
    @IBOutlet weak var emailField: UITextField!
    
    // User's password.
    @IBOutlet weak var passwordField: UITextField!
    
    // User's school.
    @IBOutlet weak var schoolField: UITextField!
    
    // User's classes.
    @IBOutlet weak var classField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        schoolField.delegate = self
        classField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Attempt to sign up.
    @IBAction func attemptSignUp(_ sender: UIButton) {
        
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        
        if (classField.text == nil || schoolField.text == nil) {
            let alert = UIAlertController(title: "Sign Up Error", message: "Please write your school and courses.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user, error) in
            if error == nil {
                let changeRequest = user!.profileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: {(err) in
                    if err == nil {
                        setUser(school: self.schoolField.text!, classes: self.classField.text!)
                        self.performSegue(withIdentifier: "signupToMain", sender: self)
                    } else {
                        print(err!)
                    }
                })
            } else {
                let alert = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    
    
    // Going to the login view controller.
    @IBAction func login(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLogIn", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
