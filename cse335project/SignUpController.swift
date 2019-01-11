//
//  SignUpController.swift
//  cse335project
//
//  Created by cballen3 on 12/22/18.
//  Copyright © 2018 cballen3. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField1: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUpThroughEmail(_ sender: Any) {
        
        //if (Auth.auth().currentUser != nil) {
            
            //etc
            
        //}
        
        
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
