//
//  SignInController.swift
//  cse335project
//
//  Created by cballen3 on 12/22/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import UIKit

class SignInController: UIViewController {

    var username: String?
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func returned3(segue: UIStoryboardSegue) {
        
        if let sourceVC = segue.source as? SignUpController {
            print("unwind from sign up")
        }
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
