//
//  NotifictionsTableViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 1/1/22.
//

import UIKit
import FirebaseAuth
import Firebase
import Foundation


class NotifictionsTableViewController: UITableViewController {

    @IBOutlet var Tableview: UITableView!
    
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    
    var tranBo = true
    var overspendBo = true
    var threshold = true
    var payCC = true
    
    @IBOutlet weak var tranButton: UISwitch!
    
    @IBOutlet weak var thresholdBtm: UISwitch!
    @IBOutlet weak var overSpentBtn: UISwitch!
    @IBOutlet weak var payCCBtn: UISwitch!
    
    @IBAction func TranNotify(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        
       if ((sender as AnyObject).isOn == true) {
                    db.collection("NotifcationSettings").document(user!.uid).updateData([
                        "TranAlert" : Bool(true)
    
                    ])
                  } else {
                      db.collection("NotifcationSettings").document(user!.uid).updateData([
                          "TranAlert" : Bool(false)
      
                      ])
                  }
    }
    
    
    @IBAction func Overspend(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        
       if ((sender as AnyObject).isOn == true) {
                    db.collection("NotifcationSettings").document(user!.uid).updateData([
                        "OverSpendAlert" : Bool(true)
    
                    ])
                  } else {
                      db.collection("NotifcationSettings").document(user!.uid).updateData([
                          "OverSpendAlert" : Bool(false)
      
                      ])
                  }
        
    }
    
    @IBAction func threshold(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        
       if ((sender as AnyObject).isOn == true) {
                    db.collection("NotifcationSettings").document(user!.uid).updateData([
                        "threholdAlert" : Bool(true)
    
                    ])
                  } else {
                      db.collection("NotifcationSettings").document(user!.uid).updateData([
                          "threholdAlert" : Bool(false)
      
                      ])
                  }
    }
    
    
    
    @IBAction func PayCC(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        
       if ((sender as AnyObject).isOn == true) {
                    db.collection("NotifcationSettings").document(user!.uid).updateData([
                        "payCC" : Bool(true)
    
                    ])
                  } else {
                      db.collection("NotifcationSettings").document(user!.uid).updateData([
                          "payCC" : Bool(false)
      
                      ])
                  }
    }
    
    
    override func viewDidLoad() {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        super.viewDidLoad()
        let docRef = self.db.collection("NotifcationSettings").document(self.uid)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                tranBo = document.get("TranAlert") as! Bool
                overspendBo = document.get("OverSpendAlert") as! Bool
                threshold = document.get("threholdAlert") as! Bool
                payCC = document.get("payCC") as! Bool
               switchMode()
            }
        }
    
        func switchMode(){
            if (tranBo == true){
                tranButton.isOn = true
            }else{
                tranButton.isOn = false
            }
        
            if (overspendBo == true){
                overSpentBtn.isOn = true
            }else{
                overSpentBtn.isOn = false
            }
        
            if (threshold == true){
                thresholdBtm.isOn = true
            }else{
                thresholdBtm.isOn = false
            }
        
            if (payCC == true){
                payCCBtn.isOn = true
            }else{
                payCCBtn.isOn = false
            }
        
        
        
        
        
        }
           
                // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
            
            
    
      
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
