//
//  User.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import Foundation

import SwiftyJSON
struct User {
    //680958295481-6kdi05n9cccfnrcp7doq8fus11k4msgu.apps.googleusercontent.com
    var firstName : String
    var lastName : String
    var password : String
    var email : String
    var id: String!
    
    init(firstname: String, password: String, email: String, lastName: String) {
        self.firstName = firstname
        self.password = password
        self.email = email
        self.lastName = lastName
    }
    
}


struct UserDataModel: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let password: String
    let email : String
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case password
        case email
    }
}
