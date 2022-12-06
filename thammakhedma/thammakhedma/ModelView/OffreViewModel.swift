//
//  OffreViewModel.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 5/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class OffreViewModel: ObservableObject {
    @Published var name : String  = ""
    @Published var email : String  = ""
    @Published var id : String  = ""
    @Published var adresse : String  = ""
    @Published var description : String  = ""
    @Published var latitud : String  = ""
    @Published var longitud : String  = ""
    func AddEntreprise(name: String,description: String,entreprise: String,userid: String) {
        let parametres: [String: Any] =
        [       "name":name,
                "description":description,
                "entreprise":entreprise,
                "user":userid]
        AF.request(Statics.URL+"/offre/Add" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
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
    func updateUser(name: String,description: String,id: String) {
        let parametres: [String: Any] = [
            "name":name,
            "description":description,
        ]
        AF.request(Statics.URL+"/offre/update/\(id ?? "")" , method: .patch,parameters:parametres ,encoding: JSONEncoding.default)
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
}
