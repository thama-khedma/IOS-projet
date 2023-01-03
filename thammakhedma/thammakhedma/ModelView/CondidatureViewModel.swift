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
    @Published var condidatures = [Condidature]()
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
    func getCondidature(){
            
            guard let url = URL(string: Statics.URL+"/condidature") else {
                print("not found")
                return
            }
            
            URLSession.shared.dataTask(with: url) {
                (data , res , error) in
                if error != nil
                {
                    print ("error", error?.localizedDescription ?? "")
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode([ Condidature].self, from: data)
                        DispatchQueue.main.async {
                            self.condidatures = result
                            
                            
                                for condidature in self.condidatures {
                                        let index = self.condidatures.firstIndex(of: condidature)
                                        self.condidatures.remove(at: index!)
                                }
                            
                            print(self.condidatures)
                        }
                    }
                    else {
                        print ("no data")
                    }
                } catch let JsonError {
                    
                    print("fetch json error :", JsonError.localizedDescription)
                    print(String(describing: JsonError))
                }
            }.resume()
        print(self.condidatures)
        }
    func getCondidatures(complited: @escaping(Bool, [Condidature]?) -> Void) {
        AF.request(Statics.URL+"/condidature/", method: .get ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    self.condidatures = []
                    for i in JSON(response.data!){
                        self.condidatures.append(Condidature(id:i.1["_id"].stringValue, entreprise_name: i.1["entreprise_name"].stringValue,user: i.1["user"].stringValue, offre: i.1["offre"].stringValue))
                    }
                    complited(true,self.condidatures)
                case let .failure(error):
                    debugPrint(error)
                complited(false,nil)
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
            "name":name,]
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
