//
//  SplashScreen.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 11/24/21.
//

import UIKit

class SplashScreen: UIViewController {

    @IBOutlet weak var SignUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpBtn.layer.cornerRadius = 10
        print("red")
        // Do any additional setup after loading the view.
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
