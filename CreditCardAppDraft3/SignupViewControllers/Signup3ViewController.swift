//
//  Signup3ViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 10/24/21.
//

import UIKit

class Signup3ViewController: UIViewController {
    var finalEmail = ""
    var firsttxt = ""
    var lasttxt = ""
    var phonenum = ""
    
    var nextseg = "false"

    
    @IBOutlet weak var FirstNameTxtField: UITextField!
    @IBOutlet weak var LastNameTxtField: UITextField!
    @IBOutlet weak var lblFirstNameError: UILabel!
    @IBOutlet weak var lblLastNameError: UILabel!
    @IBOutlet weak var ConBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLastNameError.isHidden=true
        lblFirstNameError.isHidden=true
        ConBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    @IBAction func signUpBtn(_ sender: Any) {
        self.nextseg = "false"
    }
    
    
    @IBAction func FirstLastDone(_ sender: Any) {
        self.firsttxt = FirstNameTxtField.text!
        self.lasttxt = LastNameTxtField.text!
        if firsttxt == ""{
            
            lblFirstNameError.isHidden=false
        } else if lasttxt == ""{
           
            FirstNameTxtField.backgroundColor = UIColor.white
            lblFirstNameError.isHidden=true
            lblLastNameError.isHidden=false
        }else {
            self.nextseg = "true"
            lblFirstNameError.isHidden=true
            lblLastNameError.isHidden=true
            FirstNameTxtField.backgroundColor = UIColor.white
            LastNameTxtField.backgroundColor = UIColor.white
            performSegue(withIdentifier: "NameSegue", sender: self)
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(nextseg == "true"){
        let vc1 = segue.destination as! DateSelectViewController
        vc1.finalEmail = self.finalEmail
        vc1.finalFirstN = self.firsttxt
        vc1.finalLastN = self.lasttxt
        vc1.phonenums = self.phonenum
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

}
