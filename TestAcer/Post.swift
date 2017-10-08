//
//  Post.swift
//  TestAcer
//
//  Created by Charles You on 2017-05-01.
//  Copyright © 2017 Charles You. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

let currentUser = FIRAuth.auth()?.currentUser

var imagePath = ""

let id = currentUser?.uid

let dbRef = FIRDatabase.database().reference()

// Used in Sign Up when a user first enters his/her information.
func setUser(school: String, classes: String) {
    var dict: [String : Any] = [:]
    dict["Username"] = currentUser?.displayName
    dict["Email"] = currentUser?.email
    dict["School"] = school
    dict["Courses"] = classes
    dict["Posts"] = []
    let userReference = dbRef.child("Users").child(id!)
    userReference.setValue(dict)
}


// Used to get info of the user when loading the profile page.
func getUserInfo(completion: @escaping ([String:Any]?) -> Void) {
    let userReference = dbRef.child("Users").child(id!)
    userReference.observeSingleEvent(of: .value, with: { (snapshot) in
        if snapshot.exists() {
            if let userInfo = snapshot.value as? [String:Any] {
                completion(userInfo)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    })
}

// Updating Profile
func updatingProf(n: String, s: String, c: String) {
    let userReference = dbRef.child("Users").child(id!)
    userReference.child("Username").setValue(n)
    userReference.child("School").setValue(s)
    userReference.child("Courses").setValue(c.lowercased())
}

// Getting list of classes from User node to match which posts appear in history.
func getCoursesList(completion: @escaping ([String]?) -> Void) {
    let userReference = dbRef.child("Users").child(id!)
    userReference.observeSingleEvent(of: .value, with: { (snapshot) in
        if snapshot.exists() {
            if let dic = snapshot.value as? [String:Any] {
                let courseList = dic["Courses"] as! String
                var courses: [String] = []
                let actualList = courseList.replacingOccurrences(of: " ", with: "")
                var parsedCourse: String = ""
                for char in actualList.characters {
                    if char == "," {
                        courses.append(parsedCourse.lowercased())
                        parsedCourse = ""
                    } else {
                        parsedCourse += String(char)
                    }
                }
                courses.append(parsedCourse.lowercased())
                completion(courses)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    })
}


// Uploading post to the database.
func uploadPost(locationName: String, address: String, school: String, course: String, description: String, time: String) {
    let currentPost = dbRef.child("Posts").childByAutoId()
    var dict: [String : Any] = [:]
    dict["Username"] = currentUser?.displayName
    dict["School"] = school
    dict["Course"] = course.lowercased()
    dict["Location"] = locationName
    dict["Address"] = address
    dict["Description"] = description
    dict["Time"] = time
    dict["ImagePath"] = imagePath
    currentPost.setValue(dict)
}

// Adding image to the node
func addImageToPost(postImage: UIImage) {
    let data = UIImageJPEGRepresentation(postImage, 1.0)!
    imagePath = "Images/\(UUID().uuidString)"
    store(data: data, toPath: imagePath)
}

// Store the data to the given path on the storage module using the put function.
func store(data: Data, toPath path: String) {
    let storageRef = FIRStorage.storage().reference()
    
    // YOUR CODE HERE
    storageRef.child(path).put(data, metadata: nil) { (metadata, error) in
        if let error = error {
            print(error)
        }
    }
}

// Getting the actual image in the form of data.
func getDataFromPath(path: String, completion: @escaping (Data?) -> Void) {
    let storageRef = FIRStorage.storage().reference()
    storageRef.child(path).data(withMaxSize: 5 * 1024 * 1024) { (data, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
            completion(data)
        } else {
            completion(nil)
        }
    }
}
