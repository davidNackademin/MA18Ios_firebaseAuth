//
//  AddItemViewController.swift
//  MA18FirebaseAuth
//
//  Created by David Svensson on 2019-03-29.
//  Copyright © 2019 David Svensson. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var itemNameText: UITextField!
    var db : Firestore!
    var auth : Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        auth = Auth.auth()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func add(_ sender: UIButton) {
        //let itemsRef = db.collection("items")
        guard let user = auth.currentUser else {return}
    
        let itemsRef = db.collection("users").document(user.uid).collection("items")
        
        if let name = itemNameText.text {
            let item = Item(name: name)
            itemsRef.addDocument(data: item.toAny())
        }
    }
    
}
