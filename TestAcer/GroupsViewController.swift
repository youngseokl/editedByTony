//
//  GroupsViewController.swift
//  TestAcer
//
//  Created by Charles You on 2017-04-21.
//  Copyright © 2017 Charles You. All rights reserved.
//

import UIKit
import Firebase

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cell: GroupsTableViewCell?
    var myGroups = [[String]]()
    var post = [String]()
    var selectedIndexPath: IndexPath?
    
    enum Constants {
        static let buttonBackgroundColor = UIColor.black
        static let buttonSize = 200 // random value, must change later
    }
    
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        myGroups = [[String]]()
    //        getValidPosts()
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        myGroups = [[String]]()
        //        getValidPosts()
        self.groupsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func getValidPosts() {
    //        getCoursesList() { (courseList) in
    //            if let courseList = courseList {
    //                let postsRef = FIRDatabase.database().reference().child("Posts")
    //                postsRef.observeSingleEvent(of: .value, with: { (snapshot) in
    //                    if snapshot.exists() {
    //                        if let allPosts = snapshot.value as? [String: [String:Any]] {
    //                            for item in allPosts.values {
    //                                let postClass = item["Course"] as! String
    //                                if courseList.contains(postClass) {
    //                                    var tmp = [String]()
    //                                    tmp.append(item["Username"] as! String)
    //                                    tmp.append(item["School"] as! String)
    //                                    tmp.append(postClass)
    //                                    tmp.append(item["Location"] as! String)
    //                                    tmp.append(item["Address"] as! String)
    //                                    tmp.append(item["Description"] as! String)
    //                                    tmp.append(item["Time"] as! String)
    //                                    self.myGroups.append(tmp)
    //                                }
    //                            }
    //                        }
    //                    }
    //                })
    //            }
    //        }
    //    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = myGroups.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? GroupsTableViewCell
        
        myGroups = [[String]]()
        
        getCoursesList() { (courseList) in
            if let courseList = courseList {
                let postsRef = FIRDatabase.database().reference().child("Posts")
                postsRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        if let allPosts = snapshot.value as? [String: [String:Any]] {
                            for item in allPosts.values {
                                let postClass = item["Course"] as! String
                                if courseList.contains(postClass) {
                                    var tmp = [String]()
                                    tmp.append(item["Username"] as! String)
                                    tmp.append(item["School"] as! String)
                                    tmp.append(postClass)
                                    tmp.append(item["Location"] as! String)
                                    tmp.append(item["Address"] as! String)
                                    tmp.append(item["Description"] as! String)
                                    tmp.append(item["Time"] as! String)
                                    self.myGroups.append(tmp)
                                }
                            }
                        }
                    }
                })
            }
        }

        
        post = myGroups[indexPath.row]
        cell?.userName.text = post[0]
        cell?.school_Course.text = "" + post[1] + ", " + post[2]
        cell?.timePeriod.text = post[6]
        cell?.location.text = post[3]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
        //        performSegue(withIdentifier: "secondLink", sender: selectedIndexPath)
    }
    

}
