//
//  AddyChangeViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 1/2/22.
//

import UIKit
import GooglePlaces
import FirebaseAuth
import Firebase
import Foundation

class AddyChangeViewController: UIViewController, UITextFieldDelegate {
    var StreetAddy = ""
    var City = ""
    var state = ""
    var Zip = ""
    var aptnum = ""
    
    private var tableView: UITableView!
      private var tableDataSource: GMSAutocompleteTableDataSource!
    
    @IBOutlet weak var ContinueBtn: UIButton!
    
    @IBOutlet weak var aptnumtxt: UITextField!
    @IBOutlet weak var Addylbl: UILabel!
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height*0.2+40, width:UIScreen.main.bounds.width, height: 60))
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
    
    @IBAction func saveChange(_ sender: Any) {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        
        db.collection("Users").document(user!.uid).updateData([
            "Street" : StreetAddy,
            "City" : City,
            "State": state,
            "Zip" : Zip,
            "Apt" : aptnumtxt.text
        ])
        performSegue(withIdentifier: "AddyBackSegue", sender: self)
    }
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.addSubview(searchBar)
        Addylbl.isHidden=true
        self.ContinueBtn.layer.cornerRadius = 20
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        aptnumtxt.isHidden=true
        tableView = UITableView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height*0.2+104, width: self.view.frame.size.width, height: 300))
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        tableView.isHidden=true
        self.aptnumtxt.delegate = self
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
}
    extension AddyChangeViewController: UISearchBarDelegate {
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the GMSAutocompleteTableDataSource with the search text.
        tableDataSource.sourceTextHasChanged(searchText)
      }
    }

    extension AddyChangeViewController: GMSAutocompleteTableDataSourceDelegate {
      func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator off.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // Reload table data.
        tableView.reloadData()
        tableView.isHidden=false
          
      }

      func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator on.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Reload table data.
        tableView.reloadData()
        tableView.isHidden=false
          
      }

    func searchBar1(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.isHidden=true
    }
    
        
      func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
       
        ContinueBtn.isHidden=false
        tableView.isHidden=true
        searchBar.isHidden=true
        Addylbl.isHidden=false
        aptnumtxt.isHidden=false
        view.endEditing(true)

        let addycomponets = place.formattedAddress?.components(separatedBy: ",")
        let StateZip = addycomponets?[2].components(separatedBy: " ")
        StreetAddy = addycomponets?[0] ?? "nil"
        City = addycomponets?[1] ?? "nil"
        state = StateZip?[1] ?? "nil"
        Zip = StateZip?[2] ?? "nil"
 
        Addylbl.text = place.formattedAddress
        
      }

      func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // Handle the error.
        print("Error: \(error.localizedDescription)")
      }

      func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
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
