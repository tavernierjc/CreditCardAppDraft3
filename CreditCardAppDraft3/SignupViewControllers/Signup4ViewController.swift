//
//  Signup4ViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 10/24/21.
//

import UIKit
import FirebaseAuth
import Firebase

class Signup4ViewController: UIViewController {
var finalEmail = ""
var finalFirstN = ""
var finalLastN = ""
var showError = ""
var password1 = ""
var password2 = ""
var phonenums = ""
var DateofBirth = Date()
var street = ""
var city = ""
var state = ""
var zip = ""
var aptnum = ""
    

    @IBOutlet weak var ContinueBtn: UIButton!
    
    @IBOutlet weak var Pass1: UITextField!
    @IBOutlet weak var Pass2: UITextField!
    @IBOutlet weak var Errorlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Errorlbl.isHidden=true
        ContinueBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
      
    }
    
    @IBAction func signinbtn(_ sender: Any) {
        
    }
    
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBAction func ContinueBtn(_ sender: Any) {
        self.password1 = Pass1.text!
        self.password2 = Pass2.text!
       print(password1)
        print(password2)
        print(phonenums)
        Errorlbl.isHidden=true
        if password1 != password2 {
            Errorlbl.isHidden=false
            Errorlbl.text = "Password does not match"
        }else if password2.count <= 7{
            Errorlbl.isHidden=false
           Errorlbl.text = "Password must be 7 characters"
        }
        else if (password2 == finalFirstN || password2 == finalLastN){
            Errorlbl.isHidden=false
           Errorlbl.text = "Password can not have name"
        }
        else {
            Auth.auth().createUser(withEmail: finalEmail, password: password2) { (result, err) in
                
                if err != nil{
                    //there was an error creating the user
                    let alert = UIAlertController(title: "Error", message: err!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Okay",style: .cancel,handler: nil))
                    self.present(alert,animated: true)
            }
                else{
                    let date = Date()
                    let format = DateFormatter()
                    format.dateFormat = "yy"
                    let formattedDate = format.string(from: date)
                    let calender = Calendar.current
                    
                    let db = Firestore.firestore()
                        
                        db.collection("Users").document(result!.user.uid).setData([
                            "FirstName" : self.finalFirstN,
                            "LastName" : self.finalLastN,
                            "MemberSinceYYYY" : formattedDate,
                            "MemberSinceMM" : calender.component(.month, from:date),
                            "PhoneNumber" : self.phonenums,
                            "DateofBirth" : self.DateofBirth,
                            "Street" : self.street,
                            "City" : self.city,
                            "State" : self.state,
                            "Zip" : self.zip,
                            "Apt" : self.aptnum
                            
                        ])
                    var CardTypeNum = ("\(result!.user.uid)\(self.randomString(length: 4))")
                    db.collection("Cards").document(result!.user.uid).setData([
                        "CardType1" : CardTypeNum
                        
                    ])
                    db.collection("CardType").document(CardTypeNum).setData([
                        "AccountNum" : "",
                        "Balance": 0,
                        "Guid": "",
                        "Institution_code": "",
                        "Type": "nil"
                        
                    ])
                    db.collection("NotifcationSettings").document(result!.user.uid).setData([
                        "OverSpendAlert" : true,
                        "TranAlert": true,
                        "payCC" : true,
                        "threholdAlert" : true
                        
                    ])
                    db.collection("ACB").document(result!.user.uid).setData([
                        "Bal" : 0
                    ])
                    
                    db.collection("TranSettings").document(result!.user.uid).setData([
                        "CCPayOF" : false,
                        "NoCCPayChec" : 0,
                        "PauseDwinDate" : "",
                        "TranGreaterThan" : 500,
                        "pauseDwin" : false
                    ])
                    
                        { err in
                            if let err = err {
                                let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title:"Okay",style: .cancel,handler: nil))
                                self.present(alert,animated: true)
                            } else {
                                self.performSegue(withIdentifier: "SignupSegue", sender: self)
                                print("Document added")
                            }
                        }

                    
                }
             
               
            }
             
        }
        }
    }
    

  /*
        
        var password = Pass1.text!
        
        Auth.auth().createUser(withEmail: finalEmail, password: password) { (result, err) in
            
            if err != nil{
                //there was an error creating the user
                print(err)
        }
            else{
                let db = Firestore.firestore()
                db.collection("Users").addDocument(data: ["FirstName" :self.finalFirstN, "LastName":self.finalLastN, "uid": result!.user.uid ]){ (error) in
                    
                    if error != nil {
                        
                        print("Error Saving Data")
                    }
                
            }
         
           
        }
         
    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
         */


