//
//  test.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 27/11/2022.
//
import SwiftUI
import PhotosUI
import Alamofire

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}


struct test: View {
    @State private var enableBlogger = true
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var view = UILabel()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
        var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Update Information")) {
                    
                    
                    HStack {
                        
                        TextField("First Name",
                                  text: $firstName)
                        Spacer(minLength: 100)
                    }
                    
                    
                    HStack {
                        TextField("Last Name",
                                  text: $lastName)
                        Spacer(minLength: 100)
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }){
                        Text("Update")
                            .bold()
                            .frame(width: 120, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color.purple)
                            .cornerRadius(15.0)
                            .shadow(radius: 5)
                            .buttonStyle(.bordered)
                    }
                    Spacer()
                    
                }
                
            }.navigationBarTitle(Text("Profile"))
        }
        
        
    }
    
    
    
    //upload Image
    func updateImage( imgData: Data){
        var urls = ""
        let randomID = UUID.init().uuidString
        //let params = []
        AF.upload(multipartFormData: {multiPart in
            multiPart.append(imgData, withName: "keyname", fileName: "\(randomID).jpg",mimeType: "image/*")
        },to: urls , headers: [] ).responseJSON{
            apiResponse in
            switch apiResponse.result{
            case .success(_):
                let apiDictionary = apiResponse.value as? [String:Any]
                print("apiResponse --- \(apiDictionary)")
            case .failure(_):
                print("gett an error")
            }
        }
    }
}
