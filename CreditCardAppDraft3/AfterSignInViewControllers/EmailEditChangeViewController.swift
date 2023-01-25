//
//  EmailChangeViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 1/2/22.
//

import UIKit
import FirebaseAuth
import Firebase
import Foundation

class EmailEditChangeViewController: UIViewController,UITextFieldDelegate {
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    var email:String = ""
    
    @IBOutlet weak var emailTxt: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        email = user!.email ?? ""
        self.uid = user!.uid
        emailTxt.text = email
       emailTxt.delegate = self
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func saveEmail(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        Auth.auth().currentUser?.updateEmail(to: (emailTxt.text ?? user!.email)!) { error in
          // ...
        }
        performSegue(withIdentifier: "EmailBackSegue", sender: self)
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
