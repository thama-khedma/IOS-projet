//
//  Entreprise.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 25/11/2022.
//

import Foundation
struct Entrepris {
    //680958295481-6kdi05n9cccfnrcp7doq8fus11k4msgu.apps.googleusercontent.com
    var latitud : String
    var longitud : String
    
    init(latitud: String, longitud: String) {
        self.latitud = latitud
        self.longitud = longitud
    }
    
}
//name: String,email: String,id: String,adresse: String,description: String,latitud: String,longitud: String,image: UIImage
struct Company {
    //680958295481-6kdi05n9cccfnrcp7doq8fus11k4msgu.apps.googleusercontent.com
    var name : String
    var email : String
    var iduser : String
    var adresse : String
    var description: String
    var latitud: String
    var longitud: String
    var id: String!
    var image: String
    init(name: String, email: String, iduser: String, adresse: String,description: String,latitud: String,longitud: String,image: String) {
        self.name = name
        self.email = email
        self.iduser = iduser
        self.adresse = adresse
        self.description = adresse
        self.latitud = adresse
        self.longitud = adresse
        self.image = image
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
