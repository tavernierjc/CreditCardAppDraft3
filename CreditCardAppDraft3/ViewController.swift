//
//  ViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 10/24/21.
//

import UIKit
import FirebaseAuth
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var txtboxemail: UITextField!
    @IBOutlet weak var txtboxpass: UITextField!
    
    
    
    @IBOutlet weak var lblsignup: UILabel!
    
    @IBOutlet weak var lblsignup2: UILabel!
    
    @IBOutlet weak var signBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtboxpass.layer.cornerRadius = 10
        txtboxemail.layer.cornerRadius = 10
        signBtn.layer.cornerRadius = 10
    
       
        // Do any additional setup after loading the view.
    }
    /*
    override func UserID(for segue: UIStoryboardSegue, sender: Any?){
        var usID =segue.destination as! HomeScreenViewController
        usID.
    }
    */
    
    @IBAction func Signinbtn(_ sender: Any) {
        //validate text fields
        //crEATE Cleaned version of text field
        let email = txtboxemail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtboxpass.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                let alert = UIAlertController(title: "We can't find that username and password", message: "You can reset your password or try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Reset Password",style: .default,handler: nil))
                alert.addAction(UIAlertAction(title:"Close",style: .cancel,handler: nil))
                self.present(alert,animated: true)
            }else{
                self.performSegue(withIdentifier: "HomeScreenSegue", sender: self)
                
                }
            }
        }
    }
    


