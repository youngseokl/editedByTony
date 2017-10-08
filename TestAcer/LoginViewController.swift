//
//  LoginViewController.swift
//  TestAcer
//
//  Created by Charles You on 2017-04-13.
//  Copyright © 2017 Charles You. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // User's email.
    @IBOutlet weak var emailText: UITextField!
    
    // User's password.
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        passwordText.delegate = self
    }

    // Checks if user is already signed in and skips login
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            //TODO: I need to connect to profile page!
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Attempt to login.
    @IBAction func attemptLogin(_ sender: UIButton) {
        guard let emailText = emailText.text else { return }
        guard let passwordText = passwordText.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText, completion: { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "loginToMain", sender: self)
            } else {
                let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func prepareForUnwind(storyBoard: UIStoryboardSegue) {
    }
    
    // Going to the signup view controller.
    @IBAction func signup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
