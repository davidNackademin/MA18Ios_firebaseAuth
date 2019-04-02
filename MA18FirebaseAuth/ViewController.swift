//
//  ViewController.swift
//  MA18FirebaseAuth
//
//  Created by David Svensson on 2019-03-29.
//  Copyright © 2019 David Svensson. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var db : Firestore!
    var auth : Auth!
    
    let segueId = "signedInSegue"
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        auth = Auth.auth()

        if let user = auth.currentUser {
            //print(user.email)
            performSegue(withIdentifier: segueId, sender: self)
        }
        
        do {
          try auth.signOut()
        } catch {
            print("error singing out")
        }
        
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
       signIn()
        //createUser()
    }
    
    func createUser() {
        if let email = emailText.text,
            let password = passwordText.text {
            
            auth.createUser(withEmail: email, password: password) {
                authResult, error in
                if let user = self.auth.currentUser {
                    self.performSegue(withIdentifier: self.segueId, sender: self)
                    
                }
                
            }
        }
    }
    
    func signIn() {
        if let email = emailText.text,
            let password = passwordText.text {
            
            auth.signIn(withEmail: email, password: password) { user, error in
                if let user = self.auth.currentUser {
                    self.performSegue(withIdentifier: self.segueId, sender: self)                }
            }
        }
    }
}

