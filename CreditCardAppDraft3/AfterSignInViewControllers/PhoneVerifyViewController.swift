//
//  PhoneVerifyViewController.swift
//  CreditCardAppDraft3
//
//  Created by Jordan Tavernier on 1/2/22.
//

import UIKit
import FirebaseAuth
import Firebase
import Foundation

class PhoneVerifyViewController: UIViewController {
    var phoneNumber = ""
    var db: Firestore!
    var handle: AuthStateDidChangeListenerHandle?
    var uid = ""
    
    override func viewDidLoad() {
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        self.uid = user!.uid
        
        super.viewDidLoad()
        let docRef = self.db.collection("Users").document(self.uid)
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                phoneNumber = document.get("PhoneNumber") as! String
            }
            user?.multiFactor.getSessionWithCompletion({ (session, error) in
                  // Send SMS verification code.
                  PhoneAuthProvider.provider().verifyPhoneNumber(
                    phoneNumber,
                    uiDelegate: nil,
                    multiFactorSession: session) { (verificationId, error) in
                      // verificationId will be needed for enrollment completion.
                      // Ask user for the verification code.
                      let credential = PhoneAuthProvider.provider().credential(
                        withVerificationID: verificationId!,
                        verificationCode:
                      "123")
                      let assertion = PhoneMultiFactorGenerator.assertion(with: credential)
                      // Complete enrollment. This will update the underlying tokens
                      // and trigger ID token change listener.
                        user?.multiFactor.enroll(with: assertion, displayName: "test") { (error) in
                        // ...
                      }
                  }
                })
      
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
}

