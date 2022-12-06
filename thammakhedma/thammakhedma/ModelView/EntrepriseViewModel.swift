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
    func updateUser(name: String,email: String,user: String,latitud: String,longitud: String) {
        let parametres: [String: Any] = [
            "name":name,
            "email":email,
            "user":user,
            "location":[
               "type": "Point",
               "coordinates" : [latitud,longitud]
            ]
        ]
        AF.request(Statics.URL+"/entreprise/update/\(id ?? "")" , method: .patch,parameters:parametres ,encoding: JSONEncoding.default)
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
