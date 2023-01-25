//
//  Signup1ViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 10/24/21.
//

import UIKit

class Signup1ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    var emailText = ""
    var Phonenum = ""
    @IBOutlet weak var Backbtn: UIImageView!
    @IBOutlet weak var ConBtn: UIButton!
    
    @IBOutlet weak var phonenumber: UITextField!
    
    @IBOutlet weak var InvalidEmaillbl: UILabel!
    
    var emailcheck = "False"
    var phonenumcheck = "False"
    
    @IBOutlet weak var InvalidPhoneNumlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ConBtn.layer.cornerRadius = 10
        InvalidEmaillbl.isHidden=true
        InvalidPhoneNumlbl.isHidden=true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func PhoneDash(_ sender: Any) {
        print(phonenumber.text?.count)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func EmailDone(_ sender: Any) {
        self.emailText = emailTextField.text!
        self.Phonenum = phonenumber.text!
        let atSet = CharacterSet(charactersIn: "@")
        let pSet = CharacterSet(charactersIn: ".")

        
        if self.emailText == "" {
            InvalidEmaillbl.isHidden=false
           
        }
        
        else if (emailText.rangeOfCharacter(from: atSet) != nil ){
            if (emailText.rangeOfCharacter(from: pSet) != nil) {
                InvalidEmaillbl.isHidden=true
                emailTextField.backgroundColor = UIColor.white
                emailcheck = "True"
                phonecheck()
                
                
            }

        }else{
            emailcheck = "False"
            InvalidEmaillbl.isHidden=false
           
        }
    
        
    }
    
    func phonecheck(){
        if(Phonenum.count == 10){
            InvalidPhoneNumlbl.isHidden=true
            phonenumber.backgroundColor = UIColor.white
            phonenumcheck = "True"
            performSegue(withIdentifier: "EmailSegue", sender: self)
        }else{
            phonenumcheck = "False"
            InvalidPhoneNumlbl.isHidden = false
           
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(phonenumcheck == "True" && emailcheck == "True"){
        let vc = segue.destination as! Signup3ViewController
        vc.finalEmail = self.emailText
        vc.phonenum = self.Phonenum
        }
    }
    
   
    
    /*
     
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Check phone number field and validate that the data is correct
    


    
    //Validate Phone Number
     
        
    //Create user
      
       
              // Sign in using the verificationID and the code sent to the user
              // ...
            
          }
    
    //Transiton to next screen
        
    
    

