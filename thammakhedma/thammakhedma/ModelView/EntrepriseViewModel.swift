//
//  EntrepriseViewModel.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 25/11/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine
import SwiftUI
struct Card : Identifiable {
    var id : String
    var name : String
    var email : String
    var user : String
    var expand : Bool
}
class EntrepriseViewModel: ObservableObject {
    static var Location: Entrepris?
    @Published var datas = [Card]()
    @Published var currentlocation = [Card]()
    @Published var name : String  = ""
    @Published var email : String  = ""
    @Published var id : String  = ""
    @Published var adresse : String  = ""
    @Published var user : String  = ""
    @Published var description : String  = ""
    @Published var latitud : String  = ""
    @Published var longitud : String  = ""
    func AddEntreprise(name: String,email: String,id: String,adresse: String,description: String,latitud: String,longitud: String) {
        let parametres: [String: Any] = [
            "name":name,
            "email":email,
            "user":id,
            "adresse":adresse,
            "description":description,
            "location":[
               "type": "Point",
               "coordinates" : [latitud,longitud]
            ]
        ]
        AF.request(Statics.URL+"/entreprise/Add" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
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
    func image(name: String,email: String,id: String,adresse: String,description: String,latitud: String,longitud: String,image: UIImage ) {
            
        let parametres: [String: Any?] = [
            "name":name,
            "email":email,
            "user":id,
            "adresse":adresse,
            "description":description,
            "image" : ""
            /*"location":[
               "type": "Point",
               "coordinates" : [latitud,longitud]
            ]*/
        ]
        /*let request = API.baseURL +  "/companies"
         sessionManager.upload(multipartFormData: { (multipartFormData) in
             for (key, value) in params {
                 if let val = value as? Parameters {
                     for (key1, value) in val {
                         multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: "\(key)[\(key1)]" as String)
                     }
         multipartFormData.append(imgData, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
                 } else {
                     multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                 }
             }
         }, usingThreshold: UInt64.init(), to: request, method: .post, headers: nil) { (result) in
             switch result {
             case .success(let upload, _, _):
                 upload.responseJSON { response in
                     debugPrint(response)
                     completion(true, "")
                 }
             case .failure(let encodingError):
                 print(encodingError)
                 completion(false, encodingError.localizedDescription)
             }
         }*/
        print("aaaa"+name+email+id+description+adresse)
        let imgData = image.jpegData(compressionQuality: 0.2)!
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
            for ( key,value) in parametres {
                
                multipartFormData.append(  (value as! String).data(using: .utf8)!, withName: key)
            } //Optional for extra parameters
        },
                  to:Statics.URL+"/entreprise/Add").responseData(completionHandler: { response in
            switch response.result {
            case .success:
                
                print("success image")
                
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }

    
    func DeleteEntreprise(id:String) {
        AF.request(Statics.URL+"/entreprise/delete/\(id ?? "")" , method: .post,encoding: JSONEncoding.default)
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
    
    func updateEntreprise(name: String,email: String,description: String,id:String) {
        let parametres: [String: Any] = [
            "description":description,
            "name":name,
            "email":email
        ]
        AF.request(Statics.URL+"/entreprise/update/\(id ?? "")" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
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
    
    func GetLocation(latitud: String,longitud: String) {
        print("success  \(longitud )")
        print("success  \(latitud )")
        var Location = Entrepris(latitud: latitud, longitud: longitud)
        Self.Location = Location
    }

    init() {
    }
}
