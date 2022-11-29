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
class EntrepriseViewModel: ObservableObject {
    static var Location: Entrepris?
    @Published var datas = [Card]()
    @Published var currentlocation = [Card]()
    @Published var name : String  = ""
    @Published var email : String  = ""
    @Published var id : String  = ""
    @Published var latitud : String  = ""
    @Published var description : String  = ""
    @Published var longitud : String  = ""
    func AddEntreprise(name: String,email: String,id: String,latitud: String,longitud: String) {
        let parametres: [String: Any] = [
            "name":name,
            "email":email,
            "user":id,
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
    func GetLocation(latitud: String,longitud: String) {
        print("success  \(longitud )")
        print("success  \(latitud )")
        var Location = Entrepris(latitud: latitud, longitud: longitud)
        Self.Location = Location
    }

    init() {
        self.datas = [Card]()
        AF.request(Statics.URL+"/entreprise/").responseData{
            (data) in
            let json = try! JSON(data: data.data!)
            for i in json{
                self.datas.append(Card(id:i.1["_id"].stringValue,name: i.1["name"].stringValue,email: i.1["email"].stringValue,user:i.1["user"].stringValue,expand: false))
                
            }
            
        }
        self.currentlocation = [Card]()
        AF.request(Statics.URL+"/entreprise/find/139.781/35.698").responseData{
            (data) in
            let json = try! JSON(data: data.data!)
            for i in json{
                self.currentlocation.append(Card(id:i.1["_id"].stringValue,name: i.1["name"].stringValue,email: i.1["email"].stringValue,user:i.1["user"].stringValue,expand: false))
            }
            print("LEEEEEE",self.currentlocation)
            
        }
        
    }
}
