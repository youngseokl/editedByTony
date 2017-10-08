//
//  PostViewController.swift
//  TestAcer
//
//  Created by Charles You on 2017-04-21.
//  Copyright © 2017 Charles You. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class PostViewController: UIViewController {
    
    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var selectPlaceButton: UIButton!
    @IBOutlet weak var roomNum: UITextField!
    @IBOutlet weak var schoolName: UITextField!
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var timePeriod: UITextField!
    @IBOutlet weak var shortDescription: UITextField!
    @IBOutlet weak var becomeTestAcer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
    }
    
    //    // Add a UIButton in Interface Builder, and connect the action to this function.
    //    @IBAction func getCurrentPlace(_ sender: UIButton) {
    //
    //        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
    //            if let error = error {
    //                print("Pick Place error: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            self.nameLabel.text = "No current place"
    //            self.addressLabel.text = ""
    //
    //            if let placeLikelihoodList = placeLikelihoodList {
    //                let place = placeLikelihoodList.likelihoods.first?.place
    //                if let place = place {
    //                    self.nameLabel.text = place.name
    //                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
    //                        .joined(separator: "\n")
    //                }
    //            }
    //        })
    //    }
    
    @IBAction func pickPlace(_ selectPlaceButton: UIButton) {
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                self.nameLabel.text = place.name
                self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
            } else {
                self.nameLabel.text = "No place selected"
                self.addressLabel.text = ""
            }
        })
    }
    
    @IBAction func letsBecomeTestAcer(_ becomeTestAcer: UIButton) {
        if (nameLabel.text != "Location Name" && addressLabel.text != "Location Address" && roomNum.text != "Room #" && schoolName.text != "School" && courseName.text != "Course" && timePeriod.text != "Time Period" && shortDescription.text != "Description") {
            /* Upload post to Database */
            uploadPost(locationName: nameLabel.text!, address: addressLabel.text!, school: schoolName.text!, course: courseName.text!, description: shortDescription.text!, time: timePeriod.text!)
            /* Perform Segue. */
            performSegue(withIdentifier: "updateGroups", sender: nil)
            /* Reset input fields. */
            nameLabel.text = "Location Name"; addressLabel.text = "Location Address"; roomNum.text = "Room #"; schoolName.text = "School"; courseName.text = "Course"; timePeriod.text = "Time Period"; shortDescription.text = "Description";
            /* Confirmation Alert. */
            let alert = UIAlertController(title: "Dear TestAcer", message: "Successfully posted!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            //            addPost(postImage: imageToPost, thread: threadName, username: (FIRAuth.auth()?.currentUser?.displayName)!)
        } else {
            let alert = UIAlertController(title: "Dear TestAcer", message: "Please fill in all info.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "updateGroups" {
                if let dest = segue.destination as? GroupsViewController {
                    //                    //                    dest.pokemon = pokemon!
                    //                    dest.pokemon = pokemonArray?[(selectedIndexPath?.item)!]
                    //                    if let image = cachedImages[(selectedIndexPath?.item)!] {
                    //                        cell?.pokeImage.image = image
                    //                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
