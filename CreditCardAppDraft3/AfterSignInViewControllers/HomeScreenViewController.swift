//
//  HomeScreenViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 10/26/21.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation


class HomeScreenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numinTable
    }
    
    @IBOutlet weak var lblChecknum: UILabel!
    
    
 
    var CardSelect:CGFloat = 0
    
    
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    var email = ""
    var fName = ""
    var lName = ""
    var SignupY = ""
    
    //CC Variables
    var accountNum = [String]()
    var CCBalance = [Double]()
    var InstCode = [String]()
    var CCType = [String]()
    
    var tblSelect = false

    @IBOutlet weak var AvailChecklbl: UILabel!

    @IBOutlet weak var stckviewBal: UIStackView!
    
    @IBOutlet weak var CardStack: UIStackView!
    @IBOutlet weak var ScrollCardView: UIScrollView!
    
    var stackView = UIStackView()
    var checkingBalance:Double = 0.0
    
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stckviewBal.layer.cornerRadius = 20
        stckviewBal.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        cusTableView.layer.cornerRadius=20
        cusTableView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        
        
        db = Firestore.firestore()
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
                self.uid = user.uid
                self.email = user.email!
                gathercards()
                GatherUserInfo()
                gatherChecBal()
                ScrollCardView.delegate = self
        } else {
          // No user is signed in.
          // ...
        }
        }
        
        
        // Do any additional setup after loading the view.
    }
    //This function will take card Card Primary ID and put in array
    func gathercards(){
        var cardID = [String]()
        
        let docRef = self.db.collection("Cards").document(self.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let document = document
                var cardstring = document.data().map(String.init(describing:)) ?? "nil"
                cardstring.removeLast()
                cardstring.removeFirst()
                cardID = cardstring.components(separatedBy: ", ")
                for Cards in cardID {
                    let cardNums = Cards.suffix(32)
                   
                
                    //This function will take each card ID and search for each card in database
                    //Retrive each primary cardID info from Database
                    let docRef = self.db.collection("CardType").document(String(cardNums))
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            self.accountNum.append(document.get("AccountNum") as! String)
                            self.CCType.append(document.get("Type") as! String)
                            self.CCBalance.append(document.get("Balance") as! Double)
                            self.InstCode.append(document.get("Institution_code") as! String)
                            
                            
                            
                            
                    //This function will insert each card into the UIScroll View and allow for selecred card functionality
                        }
                        //self.self.DisplayCards()
                        self.self.DisplayCards()  //print("Loop here")
                    }
                    //End of opening document for primary ID
                }//End of loop of retriveing each primary card ID
            }
            
        }//close open document for retrieving Card primary ID
        
        print("Loop here")
    }
    
  
   
    
    
    
    //This function will insert each card into the UIScroll View and allow for selecred card functionality
    
    var imageArray = [UIImage?]()
    var circleArray = [UIImage?]()
    
    var circStackwidth:CGFloat = 20
    
    func DisplayCards(){
        print("I was read here")
        for i in 0..<accountNum.count{
            let imageView = UIImageView()
            imageView.image = UIImage(named: CCType[i])
            
            let lblAccNames = UILabel()
            lblAccNames.text = ("Card Ending XXX\(accountNum[i])")
            let xPosition = self.view.frame.width * CGFloat(i) + ((self.view.frame.width/2)-137.5)
            print("This is the xpos \(xPosition)")
            lblAccNames.frame = CGRect(x: xPosition+160, y: 135, width: 200, height: 50)
            imageView.frame = CGRect(x: xPosition, y: 0, width: 275, height: self.ScrollCardView.frame.height)
            lblAccNames.textColor = UIColor.white
            lblAccNames.font = UIFont(name: "Helvetica Neue", size: 11)
            ScrollCardView.contentSize.width = ScrollCardView.frame.width * CGFloat(i+1)
            ScrollCardView.addSubview(imageView)
            ScrollCardView.addSubview(lblAccNames)
            
        
        DisplayProgressDot()
        }
    }
    //to work on tommororw
    var selectedPath:Int = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        selectedPath = indexPath.row
        tblSelect = true
        self.performSegue(withIdentifier:"transSegue", sender: self)
        
    }
    
    override func prepare(for Segue: UIStoryboardSegue, sender: Any?) {
        if tblSelect == true {
        let vc = Segue.destination as! TransactionDetails_ViewController
        vc.accountNum = self.accountNum[selectedCard]
        vc.transAmount = self.trans[selectedPath].TransAmount
        vc.Category = self.trans[selectedPath].Category
        vc.TransDesc = self.trans[selectedPath].TransDesc
        vc.TransDate = self.trans[selectedPath].Tdate
        vc.Status = self.trans[selectedPath].Status
        vc.topStatus = self.trans[selectedPath].TopLevelCat
        vc.postedOn = self.trans[selectedPath].PostedAt
        tblSelect = false
        }
    }
    
    
    
    func DisplayProgressDot(){
        let pageNum = ScrollCardView.contentOffset.x / ScrollCardView.frame.size.width
        for view in self.CardStack.arrangedSubviews{
        self.CardStack.removeArrangedSubview(view)
        view.removeFromSuperview()
        }
        
        for i in 0..<accountNum.count{
            if i != Int(pageNum){
                let circleView = UIImageView()
                circleView.image = UIImage(systemName: "circle.fill")
                circleView.tintColor = .gray
                CardStack.widthAnchor.constraint(equalToConstant: circStackwidth)
                circStackwidth += 20
                CardStack.distribution = .fillEqually
                CardStack.addArrangedSubview(circleView)
            }else{
                let circleView = UIImageView()
                circleView.image = UIImage(systemName: "circle.fill")
                circleView.tintColor = .systemBlue
                CardStack.widthAnchor.constraint(equalToConstant: circStackwidth)
                circStackwidth += 20
                CardStack.distribution = .fillEqually
                CardStack.addArrangedSubview(circleView)
            }
            
        }
        cusTableView.reloadData()
    }
    
    
    
    
    var yTable:CGFloat = 0
    var selectedCard:Int = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNum = ScrollCardView.contentOffset.x / ScrollCardView.frame.size.width

        if pageNum == Double(Int(pageNum)) && cusTableView.contentOffset.y == yTable{
            DisplayProgressDot()
            selectedCard = Int(pageNum)
            }
        yTable = cusTableView.contentOffset.y
        }
            
        

    //print("function called")
        //if(ScrollCardView.panGestureRecognizer.translation(in: ScrollCardView.superview).x > 0){
         //   print("Left")
        //}else{
            
        //   print("Right")
       // }
        // This method is called as the user scrolls
    
  
    
    @IBOutlet weak var Goodmessage: UILabel!
    @IBOutlet weak var MemSince: UILabel!
    @IBOutlet weak var TransOverall: UIStackView!
    
    struct connectCards {
        var Fingerprint:String
        var cardType:String
        var CardShortNum:Int
        
    }
    
    
    
    
    struct Tran {
        var TransDesc:String
        var TransAmount:Double
        var Tdate:Date
        var Category:String
        var Status:String
        var TopLevelCat:String
        var PostedAt:Date
    }
    var trans = [Tran]()
   
    @IBAction func testbtn(_ sender: Any) {
        var i=0
        self.trans.sort(by: {$1.Tdate < $0.Tdate})
        for trran in self.trans{
            let label = UILabel()
            let dateFormatter2 = DateFormatter()
            label.text = dateFormatter2.string(from: trran.Tdate)
            TransOverall.addArrangedSubview(label)
        
            print(trran.TransDesc,trran.TransAmount,trran.Tdate)
            i=i+1
        }//end of create objects for view

    }

    public var tranListArray = [String]()
    
    func GatherUserInfo(){

        let docRef = self.db.collection("Users").document(self.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
            
                self.fName = document.get("FirstName") as! String
                self.lName = document.get("LastName") as! String
                self.SignupY = document.get("MemberSinceYYYY") as! String
               
                var goodMess:String = ""
                let hour = Calendar.current.component(.hour, from: Date())
                switch hour {
                case 6..<12 : goodMess = "Good Morning,"
                case 12..<17 : goodMess = "Good Afternoon,"
                case 17..<22 : goodMess = "Good Evening,"
                default: goodMess = "Good Evening,"
                }
                
                self.Goodmessage.text = "\(goodMess) \(self.fName.uppercased())"
                self.MemSince.text = "Member Since '\(self.SignupY.suffix(2))"
            } else {
                print("Document does not exist")
            }
        }
        GatherTransbyUser()
    }
       
    func gatherChecBal(){
        let docRef = self.db.collection("ACB").document(self.uid)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                self.checkingBalance = document.get("Bal") as! Double
                lblChecknum.text = String("$ \(self.checkingBalance)")
            }
        }
        
    }
    
    
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    
    func GatherTransbyUser(){
        let TranListDoc = self.db.collection("TransByUser").document(uid)
        TranListDoc.getDocument { (document, error) in
            let document = document
            var TranList = document?.data().map(String.init(describing:)) ?? "nil"
                TranList.removeLast()
                TranList.removeFirst()
                //PUTTING TRANSACTIONS IN ARRAY
            self.tranListArray = TranList.components(separatedBy: ", ")
            self.self.ArrayTransactions()
        }
        
    }
    
    func ArrayTransactions(){
        for TranID in self.tranListArray {
                    //Getting actual number from array of listed trans numbers
                    let TranIDInt = TranID.suffix(13)
                    let listedTran = self.db.collection("TransID").document(String(TranIDInt))
                    listedTran.getDocument {(document, error) in
                        if let document2 = document, document2.exists {
                            let TranDesc = document2.get("TransDesc") ?? "nil"
                            let TranAmount = document2.get("TransAmount") ?? "nil"
                            let TranCat = document2.get("Category") ?? "nil"
                            let TranTopCat = document2.get("top_level_category") ?? "nil"
                            let postedDate = document2.get("posted_at") ?? "nil"
                            let TranDate = document2.get("Date") ?? ""
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            //APPENDING THE TRANSACTION TO NESTED ARRAY
                            self.trans.append(Tran(TransDesc:TranDesc as! String, TransAmount: TranAmount as! Double,Tdate: dateFormatter.date(from: TranDate as! String) ?? Date.distantPast, Category: TranCat as! String, Status: TranTopCat as! String, TopLevelCat: TranTopCat as! String, PostedAt: dateFormatter.date(from: postedDate as! String) ?? Date.distantPast))
                            
                            //organize data
                            if(self.trans.count == self.tranListArray.count){
                                self.OrganizeTransList()
                                print("count \(self.trans.count)")
                            }
                            
                        }else{//END OF TEST FOR IF TRANS ID IS FOUND IN DOCUMENT
                       print("No Trans")
                        }
                        
                    }
                }
        
    }
    var numofTran:Int = 0
    var numinTable:Int = 0
    var currenttrans:Int=0
    
    func OrganizeTransList(){
    
        self.trans.sort(by: {$0.Tdate > $1.Tdate})
        for trran in self.trans{
            print(trran.TransDesc,trran.TransAmount,trran.Tdate)
        numinTable+=1
        tableheight+=60
        }
        //create arrays to match same dated transactions

        
        pasteobjects()
    }
    
    @IBOutlet weak var cusTableView: UITableView!
  
    
    var post:Int = 0
    
    
    var tableheight:CGFloat = 0
    
    func pasteobjects(){

        cusTableView.delegate = self
        cusTableView.dataSource = self
        cusTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! HomeScreenTableViewCell
        let transactions = trans[indexPath.row]
        tableView.rowHeight = 80
        //cell.TranAmount?.text = transactions.TransAmount!
        
        cell.TranName.text = transactions.TransDesc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        cell.TranDate.text = dateFormatter.string(from: transactions.Tdate)
        
        cell.TranAmount.text = String("$\(transactions.TransAmount)")
        cell.TranShortCode.text = String(transactions.TransDesc.prefix(1))
        return cell

    }
        
      
}
