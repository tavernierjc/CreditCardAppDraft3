//
//  SettingsViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 12/29/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tblViewSetting: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewSetting.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        addSettings()
    }
    
    func addSettings(){
        
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
