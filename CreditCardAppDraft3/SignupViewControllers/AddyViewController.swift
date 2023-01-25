//
//  AddyViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 11/24/21.
//
import GooglePlaces
import UIKit

class AddyViewController: UIViewController {
    var finalEmail = ""
    var finalFirstN = ""
    var finalLastN = ""
    var phonenums = ""
    var date = Date()
    var nextseg = "false"
    var StreetAddy = ""
    var City = ""
    var state = ""
    var Zip = ""
    var aptnum = ""
    
    private var tableView: UITableView!
      private var tableDataSource: GMSAutocompleteTableDataSource!
    
 
    @IBOutlet weak var accountlbl: UIButton!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var aptnumtxt: UITextField!
    @IBOutlet weak var Addylbl: UILabel!
    @IBOutlet weak var ContinueBtn: UIButton!
 
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height*0.2+20, width:UIScreen.main.bounds.width, height: 60))
    
    @IBAction func CtnBtn(_ sender: Any) {
        nextseg = "true"
        aptnum = aptnumtxt.text ?? ""
        performSegue(withIdentifier: "AddySegue", sender: self)
    }
    
    @IBAction func backbtn(_ sender: Any) {
        nextseg = "false"
    }
    
    @IBAction func signupbtn(_ sender: Any) {
        nextseg = "false"
    }
    
    
    @IBAction func EditBtn(_ sender: Any) {
        
        ContinueBtn.isHidden=true
        tableView.isHidden=false
        searchBar.isHidden=false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(nextseg == "true"){
            
        let vc1 = segue.destination as! Signup4ViewController
            vc1.finalEmail = self.finalEmail
            vc1.finalFirstN = self.finalFirstN
            vc1.finalLastN = self.finalLastN
            vc1.phonenums = self.phonenums
            vc1.DateofBirth = self.date
            vc1.street = self.StreetAddy
            vc1.city = self.City
            vc1.state = self.state
            vc1.zip = self.Zip
            vc1.aptnum = self.aptnum
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self

        tableView = UITableView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height*0.2+84, width: self.view.frame.size.width, height: 300))
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        tableView.isHidden=true
        view.addSubview(tableView)
        
        //Remove Fields for search
       
        ContinueBtn.isHidden=true
        Addylbl.isHidden=true
        aptnumtxt.isHidden=true
        ContinueBtn.layer.cornerRadius = 10
        accountlbl.isHidden=true
        stackview.isHidden=true
     
      }
    }


    extension AddyViewController: UISearchBarDelegate {
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the GMSAutocompleteTableDataSource with the search text.
        tableDataSource.sourceTextHasChanged(searchText)
      }
    }

    extension AddyViewController: GMSAutocompleteTableDataSourceDelegate {
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
        accountlbl.isHidden=false
        stackview.isHidden=false

        let addycomponets = place.formattedAddress?.components(separatedBy: ",")
        let StateZip = addycomponets?[2].components(separatedBy: " ")
        StreetAddy = addycomponets?[0] ?? "nil"
        City = addycomponets?[1] ?? "nil"
        state = StateZip?[1] ?? "nil"
        Zip = StateZip?[2] ?? "nil"
        nextseg = "true"
        Addylbl.text = place.formattedAddress
        
      }

      func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // Handle the error.
        print("Error: \(error.localizedDescription)")
      }

      func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
      }
    }

          
