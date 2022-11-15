//
//  User.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import Foundation

struct User {
    
    var firstName : String
    var lastName : String
    var password : String
    var email : String
 
    
    init(firstname: String, password: String, email: String, lastName: String) {
        self.firstName = firstname
        self.password = password
        self.email = email
        self.lastName = lastName
   
    }
    
}

struct UserDataModel: Decodable {
    let firstName: String
    let lastName: String
    let password: String
    let email : String
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case password
        case email
    }
}
