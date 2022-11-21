//
//  User.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//
import Foundation
import Alamofire
import SwiftyJSON
import Combine
class UserViewModel: ObservableObject {
    @Published var datas = [UserDataModel]()
    
    var firstName : String = ""
    var lastName : String  = ""
    @Published var password : String  = "azerty"
    @Published var email : String  = "monaem.hmila@esprit.tn"
    var code : String = ""
    @Published var newPassword : String = ""
    @Published var isEmailCriteriaValid = false
    @Published var isPasswordCriteriaValid = false
    @Published var isPasswordConfirmValid = false
    @Published var canSubmit = false
    @Published var confirmPw = ""
    static var currentUser: User?
    private var cancellableSet: Set<AnyCancellable> = []
    static let sharedInstance = UserViewModel()
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
    
    init() {
        $email
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isEmailCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .map { password in
                return self.passwordPredicate.evaluate(with: password)
            }
            .assign(to: \.isPasswordCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $confirmPw)
            .map { password, confirmPw in
                return password == confirmPw
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    
        Publishers.CombineLatest3($isEmailCriteriaValid, $isPasswordCriteriaValid, $isPasswordConfirmValid)
            .map { isEmailCriteriaValid, isPasswordCriteriaValid, isPasswordConfirmValid  in
                return (isEmailCriteriaValid && isPasswordCriteriaValid && isPasswordConfirmValid )
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    var confirmPwPrompt: String {
        isPasswordConfirmValid ?
            ""
            :
            "Password fields to not match"
    }
    
    var emailPrompt: String {
        isEmailCriteriaValid ?
            ""
            :
            "Enter a valid email address"
    }
    
    var passwordPrompt: String {
        isPasswordCriteriaValid ?
            ""
            :
            "Must be at least 8 characters containing at least one number and one letter and one special character."
    }
    
    func LogIn(email: String,password: String, complited: @escaping(User?)-> Void )
    {
        
        AF.request(Statics.URL+"/user/Login" , method: .post, parameters: ["email": email,"password": password] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON {
                (response) in
                switch response.result {
                    
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    let userResponse = response.object(forKey: "user") as! NSDictionary
                    let email = userResponse.object(forKey: "email") as? String ?? ""
                    let lastName = userResponse.object(forKey: "last_name") as? String ?? ""
                    let password = userResponse.object(forKey: "password") as? String ?? ""
                    let firstName = userResponse.object(forKey: "first_name") as? String ?? ""
                    let id = userResponse.object(forKey: "_id")  as? String ?? ""
                    print("success  \(email )")
                    print("success  \(lastName )")
                    print("success  \(password )")
                   var currentUser = User(firstname: firstName, password: password, email: email, lastName: lastName)
                    currentUser.id = id
                    Self.currentUser = currentUser
                  
                    print("success \(JSON )")
                   
                    complited(currentUser)
                case .failure(let error):
                    print("request failed \(error)")
                    complited(nil)
                }
            }
        // print("email : ",email)
        //print("password",password)
        
    }
    func ForgetPassword(email: String,onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        AF.request(Statics.URL+"/user/resetpwd" , method: .post, parameters: ["email": email] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON {
                (response) in
                switch response.result {
                case .success(let JSON):
                    print("success \(JSON)")
                    onSuccess()
                    
                case .failure(let error):
                    //print("request failed \(error)")
                    onError(error.localizedDescription)
                    
                    //response in debugPrint(response)
                    if error != nil {
                        onError(error.localizedDescription)
                        return
                        
                    }                }
            }
        // print("email : ",email)
        //print("password",password)
        
    }
    func ResetCode(code: String,password: String ,onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        AF.request(Statics.URL+"/user/resetpassword" , method: .post, parameters: ["code": code,"password": password] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON {
                (response) in
                switch response.result {
                case .success(let JSON):
                    print("success \(JSON)")
                    onSuccess()
                    
                case .failure(let error):
                    //print("request failed \(error)")
                    onError(error.localizedDescription)
                    
                    //response in debugPrint(response)
                    if error != nil {
                        onError(error.localizedDescription)
                        return
                        
                    }                }
            }
        // print("email : ",email)
        //print("password",password)
        
    }
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
    func updateUser(user: User) {
        print(user)
        let parametres: [String: Any] = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
            "password": user.password,
            
        ]
        AF.request(Statics.URL+"/user/updateUser/\(user.id ?? "")" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData(completionHandler: {
            response in
            switch response.result {
            case .success:
                
                print("success update")
                
            case .failure(let encodingError):
                print(encodingError)
            }
        })
        
    }
    
    func VerifyAccount(emailToken: String) {
        let parametres: [String: Any] = [
            "token":emailToken
        ]
        AF.request(Statics.URL+"/user/verify" , method: .post,parameters: parametres,encoding: JSONEncoding.default)
            .responseJSON {
                (response) in
                switch response.result {
                case .success(let JSON):
                    print("success \(JSON)")
                case .failure(let error):
                    print("request failed \(error)")
                }
            }
    
    }
    
    /*
    func Update(user: User) {
        
        print(user)
        let parametres: [String: Any] = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
            "password": user.password,
        ]
        AF.request(Statics.URL+"/user/Update", method: .put, parameters: parametres, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteAccount() {
        AF.request(Statics.URL+"/user/Delete", method: .delete, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var request = AF.request("http://172.20.10.3:3000/api/user")
    func getMyData(user: User) {
            // Send request to your mockable.io link
        print(user)
        request.responseDecodable(of: UserDataModel.self) { [weak self] (response) in
                // Make sure the data and self are not empty
                guard let data = response.value, let strongSelf = self else { return }
                // Assign the retrieved data to your objects.
           

            }
        }
    */
    
    
}
