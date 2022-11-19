//
//  User.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//
import Foundation
import Alamofire
import SwiftyJSON
class UserViewModel: ObservableObject {
    @Published var datas = [UserDataModel]()
    var firstName : String = ""
    var lastName : String  = ""
    var password : String  = ""
    var email : String  = ""
    var code : String = ""
    static let sharedInstance = UserViewModel()
    
    func Profile(id: Int) {
        
        AF.request(Statics.URL+"/user/profile/\(id)").responseData{
            (data) in
            let json = try! JSON(data: data.data!)
            for i in json{
                self.datas.append(UserDataModel(id: i.1["id"].intValue,firstName: i.1["first_name"].stringValue,lastName: i.1["last_name"].stringValue, password: i.1["password"].stringValue,email: i.1["email"].stringValue))
            }
            
            }
        
    }
    func LogIn(email: String,password: String ,onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        AF.request(Statics.URL+"/user/Login" , method: .post, parameters: ["email": email,"password": password] ,encoding: JSONEncoding.default)
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
    func SignUp(user: User,onSuccess: @escaping() -> Void) {
        print(user)
        let parametres: [String: Any] = [
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
            "password": user.password,
            
        ]
        AF.request(Statics.URL+"/user/compte" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    print("success")
                    onSuccess()
                case let .failure(error):
                    print(error)
                    
                }
            }
        
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
