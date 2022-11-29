//
//  Entreprise.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 25/11/2022.
//

import Foundation
import SDWebImage
struct Entrepris {
    //680958295481-6kdi05n9cccfnrcp7doq8fus11k4msgu.apps.googleusercontent.com
    var latitud : String
    var longitud : String
    
    init(latitud: String, longitud: String) {
        self.latitud = latitud
        self.longitud = longitud
    }
    
}

struct Entreprise: Decodable {
    var name:String?
    var email:String?
    var user:String?
    var location:String?
    
    enum CodingKeys: String, CodingKey{
    case name = "name"
    case email = "email"
    case user = "user"
    case location = "location"  
    }
}
struct datatype : Identifiable{
    var id : String
    var name:String
    var email:String
    var user:String
}
