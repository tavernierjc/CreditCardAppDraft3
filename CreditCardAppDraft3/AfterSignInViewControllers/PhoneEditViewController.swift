//
//  PhoneEditViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 1/2/22.
//

import UIKit
import FirebaseAuth
import Firebase
import Foundation

class PhoneEditViewController: UIViewController, UITextFieldDelegate {
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    
    var phoneNum = ""
    @IBOutlet weak var phoneEditTxt: UITextField!
    @IBOutlet weak var phoneEdit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneEditTxt.delegate = self
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        let docRef = self.db.collection("Users").document(self.uid)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                phoneNum = document.get("PhoneNumber") as! String
                phoneEdit.text = phoneNum
            }
            
        }
            
            
        
        // any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        db.collection("Users").document(user!.uid).updateData([
            "PhoneNumber" : phoneEdit.text
        ])
        performSegue(withIdentifier: "PhoneBackSegue", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
