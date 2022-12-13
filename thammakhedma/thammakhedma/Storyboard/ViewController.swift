//
//  ViewController.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 24/11/2022.
//

import UIKit
import GoogleSignIn
import Alamofire
class ViewController: UIViewController {
    static var CurrentUser: User?
    func SignUp(user: User) {
        print(user)
        let parametres: [String: Any] = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
            "password": user.password,
            
        ]
        AF.request(Statics.URL+"/user/compte" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    print("success")
                case let .failure(error):
                    print(error)
                }
            }
        
    }
    let signInConfig = GIDConfiguration(clientID: "680958295481-2hhdp3g45kvivsh25sgv0kvgor46sjan.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            let emailAddress:String = user.profile?.email  ?? ""
            let fullName:String = user.profile?.name ?? ""
            let givenName:String = user.profile?.givenName ?? ""
            let familyName:String = user.profile?.familyName ?? ""
            print(emailAddress,fullName,givenName)
            var currentUser = User(firstname: givenName, password: "123456789", email: emailAddress, lastName: familyName,image: "")
            ViewController.CurrentUser = currentUser
            print(ViewController.CurrentUser,emailAddress,fullName,currentUser)
            self.SignUp(user: User(firstname: givenName, password:"123456789", email: emailAddress, lastName: familyName,image: ""))
        }
    }
    
}
