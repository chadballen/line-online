//
//  RestaurantViewController.swift
//  cse335project
//
//  Created by cballen3 on 11/18/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import Firebase
import UIKit

class RestaurantViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var restaurantName: String?
    var restaurantAddress: String?
    var restaurantLat: Int?
    var restaurantLong: Int?
    
    var reviewImage: UIImage? = nil
    
    var reviewList: [Review] = []
    
    @IBOutlet var reviewTable: UITableView!
    @IBOutlet weak var orderingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var imageSource: UISegmentedControl!
    
    let picker = UIImagePickerController()
    var model: Model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self

        print(restaurantName!)
        print(restaurantAddress!)
        
        // set cell height
        self.reviewTable.estimatedRowHeight = 113
        self.reviewTable.rowHeight = 113
        
        // Firebase Load
        let restaurantsReference = Database.database().reference().child("restaurants")
        let reviewReference = restaurantsReference.child(restaurantName!+restaurantAddress!)
        let reviewOrderReference = reviewReference.child("0")
        
        // Call observe function to set up observer
        reviewOrderReference.observe(.value, with: { snapshot in
            
            // Create list
            var newList: [Review] = self.model.LoadReviewTable(snapshot: snapshot)
            
            self.reviewList = newList
            self.reviewTable.reloadData()
            
        })
        
        
        // flip UITableView axis (shows reviews bottom to top)
        //updateTableContentInset()
        //reviewTable.transform = CGAffineTransform(scaleX: 1, y: -1)
        //orderingSegmentedControl.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reviewList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCellid", for: indexPath) as! RestaurantCell
        // Configure the cell
        if reviewList[indexPath.row].lineName != "" {
            cell.beforeLineName!.text = reviewList[indexPath.row].lineName
            cell.isAuthorLabel!.text = "-- by"
        }
        else {
            cell.beforeLineName!.text = ""
            cell.isAuthorLabel!.text = ""
        }
        cell.beforeLineDuration!.text = reviewList[indexPath.row].lineDuration
        cell.beforeLineTimePosted!.text = reviewList[indexPath.row].lineTimePosted
        cell.beforeLineDescription!.text = reviewList[indexPath.row].lineDescription
        
         // Check if review has an image and update its cell accordingly
        if reviewList[indexPath.row].lineHasImage == "false" {
            // no [IMG] text
            cell.beforeIsImage!.text = ""
        }
        else {
            cell.beforeIsImage!.text = "[IMG]"
        }

        return cell
    }
    
    func updateTableContentInset() {
        let numRows = tableView(self.reviewTable, numberOfRowsInSection: 0)
        var contentInsetTop = self.reviewTable.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.reviewTable.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        self.reviewTable.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0)
    }
    
    @IBAction func AddItem(_ sender: Any) {
        
        // reference to root of JSON tree in firebase database
        let rootReference = Database.database().reference()
        
        // restaurants reference, this is a child of the root that is used to hold data
        let restaurantsReference = rootReference.child("restaurants")
        
        // review reference is the child of restaurants corresponding to the certain restaurant the user is checking reviews of
        let reviewReference = restaurantsReference.child(restaurantName!+restaurantAddress!)
        
        // review order reference is the child of review reference that splits the reviews between the before lines and after lines
        let reviewOrderReference = reviewReference.child(String(orderingSegmentedControl.selectedSegmentIndex))
        
        /// Alert Controller
        
        // Create alert with title name
        let alert = UIAlertController(title: "Add Line Review", message: nil, preferredStyle: .alert)
        
        // add cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // first textfield, where user optionally enters name
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Your name (optional)"
        })
        
        // add textfield where user enters wait time
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Description of wait time"
        })
        
        // second textfield where user optionally enters description
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Any further details (optional)"
        })
        
        // Add button that calls handler, which adds review to firebase
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { action in
            
            var hasImage: String = ""
            var imagePath: String = ""
            
            if alert.textFields![1].text == "" {
                let alertErr = UIAlertController(title: "No wait time entered", message: "Please enter a wait time for the line", preferredStyle: UIAlertControllerStyle.alert)
                alertErr.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show alert
                self.present(alertErr, animated: true, completion: nil)
            }
            else {
            // lets user upload image
            if self.imageSource.selectedSegmentIndex == 1 { // photo library
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.picker.modalPresentationStyle = .popover
                self.present(self.picker, animated: true, completion: nil)
                hasImage = "true"
            }
            else if self.imageSource.selectedSegmentIndex == 2 { // camera
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = UIImagePickerControllerSourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.modalPresentationStyle = .fullScreen
                    self.present(self.picker, animated: true, completion: nil)
                    hasImage = "true"
                }
                else {
                    print("Camera not found")
                }
            }
            else if self.imageSource.selectedSegmentIndex == 3 { // web
                /*
                let alertURL = UIAlertController(title: "Enter Image URL", message: "Please enter the web URL of the image", preferredStyle: UIAlertControllerStyle.alert)
                alertURL.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "www.mysite.com/image.jpeg"
                    
                    // get image path
                    imagePath = (alertURL.textFields?.first?.text)!
                })
                // show alert
                self.present(alertURL, animated: true, completion: nil)
                */
                hasImage = "url"
            }
            else { // no image
                hasImage = "false"
            }
            
            // set up time getter
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let currentDate = Date()
            
            let name = alert.textFields?.first?.text
            let timeDuration = alert.textFields![1].text
            let timePosted = dateFormatter.string(from: currentDate)
            let desc = alert.textFields![2].text

            
            // Adds review to the database
            // key == time of review posted
            let reviewKey = timePosted
            
            // create node
            let destinationReference = reviewOrderReference.child(reviewKey)
            
            // add restaurant review as dictionary value
                let review = ["name" : name, "timeDuration" : timeDuration, "timePosted" : timePosted, "description" : desc, "hasImage" : hasImage, "imagePath" : imagePath]
            
            destinationReference.setValue(review)
                
            }
        }))
        
        // present alert so user can see it
        self.present(alert, animated: true)
    }

    // Prepare Segue Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "reviewSegueView" {
            let destination = segue.destination as! ReviewViewController
            let selectedIndex: IndexPath = self.reviewTable.indexPath(for: sender as! UITableViewCell)!
            destination.lineName = reviewList[selectedIndex.row].lineName
            destination.lineDuration = reviewList[selectedIndex.row].lineDuration
            destination.lineTimePosted = reviewList[selectedIndex.row].lineTimePosted
            destination.lineDescription = reviewList[selectedIndex.row].lineDescription
            destination.lineImage = reviewImage
            destination.lineImagePath = reviewList[selectedIndex.row].lineImagePath
            
            destination.restaurantName = restaurantName!
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker .dismiss(animated: true, completion: nil)

        reviewImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        if reviewImage != nil {
            print("Image gotten successfully!")
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func returned2(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? ReviewViewController {
            print("unwind from review details")
        }
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        var newerList: [Review] = []
        
        // Firebase Load
        let restaurantsReference = Database.database().reference().child("restaurants")
        let reviewReference = restaurantsReference.child(restaurantName!+restaurantAddress!)
        
        switch(sender.selectedSegmentIndex) {
        case 0: // before line
            let reviewOrderReference = reviewReference.child("0")
            
            // Call observe function to set up observer
            reviewOrderReference.observe(.value, with: { snapshot in
                
                // Create list
                newerList = self.model.LoadReviewTable(snapshot: snapshot)
                
                self.reviewList = newerList
                self.reviewTable.reloadData()
                
            })
            self.reviewList = newerList
            self.reviewTable.reloadData()
            break
            
        case 1: // after line
            let reviewOrderReference = reviewReference.child("1")
            
            // Call observe function to set up observer
            reviewOrderReference.observe(.value, with: { snapshot in
                
                // Create list
                newerList = self.model.LoadReviewTable(snapshot: snapshot)
                
                self.reviewList = newerList
                self.reviewTable.reloadData()
                
            })
            self.reviewList = newerList
            self.reviewTable.reloadData()
            break
            
        default:
            break
        }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
