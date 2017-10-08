//
//  UpdateProfileViewController.swift
//  TestAcer
//
//  Created by Charles You on 2017-04-21.
//  Copyright © 2017 Charles You. All rights reserved.
//

import UIKit
import Firebase

class UpdateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Profile picture.
    @IBOutlet weak var profilePic: UIImageView!
    
    // Name.
    @IBOutlet weak var nameText: UITextField!
    
    // Email.
    @IBOutlet weak var actualEmail: UILabel!
    
    // School.
    @IBOutlet weak var schoolText: UITextField!
    
    // Courses.
    @IBOutlet weak var coursesText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserInfo() { (userInfo) in
            if let userInfo = userInfo {
                self.actualEmail.text = userInfo["Email"] as! String?
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImageButtonPressed(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated:true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profilePic.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // Updates the profile.
    @IBAction func updateProfile(_ sender: UIButton) {
        updatingProf(n: nameText.text!, s: schoolText.text!, c: coursesText.text!)
        /* Converted UIImage into JPEG Data.
         Need to store this data in the storage and update firebase.
         */
        addImageToPost(postImage: profilePic.image!)
        self.performSegue(withIdentifier: "toProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toProfile" {
                if let dest = segue.destination as? ProfileViewController {
                    dest.profilePic.image = profilePic.image
                }
            }
        }
    }
    
}
