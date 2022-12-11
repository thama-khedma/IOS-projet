//
//  CondidatureViewModel.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 11/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class CondidatureViewModel: ObservableObject {
    @Published var name : String  = ""
    @Published var user : String  = ""
    @Published var description : String  = ""
    @Published var entreprise : String  = ""
    func AddCondidature(entreprise_name: String,offre_decription: String,user: String,offre: String) {
        let parametres: [String: Any] =
        [       "entreprise_name":entreprise_name,
                "offre_decription":offre_decription,
                "user":user,
                "offre":offre
        ]
        AF.request(Statics.URL+"/condidature/Add" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
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
    
    func DeleteCondidature(id:String) {
        AF.request(Statics.URL+"/Condidature/delete/\(id ?? "")" , method: .post,encoding: JSONEncoding.default)
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
    func updateCondidature(name: String,description: String,id:String) {
        let parametres: [String: Any] = [
            "description":description,
            "name":name,
        ]
        AF.request(Statics.URL+"/offre/update/\(id ?? "")" , method: .post,parameters:parametres ,encoding: JSONEncoding.default)
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
