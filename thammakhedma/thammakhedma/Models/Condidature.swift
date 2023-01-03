//
//  Condidature.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 28/12/2022.
//
import Foundation
import SwiftUI

struct Condidature: Identifiable, Codable, Hashable {
    
    var id : String
    var entreprise_name : String
    var user : String
    var offre : String
    

    init(id: String,entreprise_name: String, user: String, offre: String) {
        
        self.id = id
        self.entreprise_name = entreprise_name
        self.user = user
        self.offre = offre
        
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "_id"
        case entreprise_name = "entreprise_name"
        case user
        case offre
        
    }
}

struct  CondidatureDataModel:Codable{
    let Condidatures:[Condidature]
}
