//
//  ReviewViewController.swift
//  cse335project
//
//  Created by cballen3 on 11/19/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var lineTimePostedLabel: UILabel!
    @IBOutlet weak var lineDurationLabel: UILabel!
    @IBOutlet weak var lineDescriptionLabel: UILabel!
    @IBOutlet weak var lineUIImage: UIImageView!
    
    var lineName: String?
    var lineDuration: String?
    var lineTimePosted: String?
    var lineDescription: String?
    var lineImage: UIImage?
    var lineImagePath: String?
    
    var restaurantName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(restaurantName) Reviews"

        lineDurationLabel.text = lineDuration
        lineTimePostedLabel.text = lineTimePosted
        lineNameLabel.text = lineName
        lineDescriptionLabel.text = lineDescription
        if lineImage != nil {
        lineUIImage.image = lineImage
        }
        else {
            lineUIImage.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
