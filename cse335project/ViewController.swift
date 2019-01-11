//
//  ViewController.swift
//  cse335project
//
//  Created by cballen3 on 10/15/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var usernameName: String?
    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        frontImage.image = UIImage(named: "queue.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func returned(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? RestaurantSelectController {
            print("unwind from restaurant select")
        }
        if let sourceVC = segue.source as? SignInController {
            print("unwind from sign in")
            usernameName = sourceVC.username
            welcomeMessage.text = "Welcome, \(usernameName)"
        }
    }
    
    
    
}
