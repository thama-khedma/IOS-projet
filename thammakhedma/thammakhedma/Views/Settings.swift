//
//  Settings.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 29/12/2022.
//

import SwiftUI

struct Settings: View {
    
    @State var type : String = "user"
    @Environment(\.colorScheme) var scheme
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @State    var urlpay = "http://127.0.0.1:3000/privecy"
    @State var showWeb = false
    var body: some View {
        
        VStack{
            Form{
                         
                    Section(header: Text("Edit Personal Information")){
                        NavigationLink(destination: profile().navigationBarBackButtonHidden(false)) {
                            Image(systemName: "person.fill")
                            Text("Edit Profile")
                        }.padding()
                        
                        NavigationLink(destination: ForgetView().navigationBarBackButtonHidden(false)) {
                            Image(systemName: "lock.fill")
                            Text("Change Password")
                        }.padding()
                        
                           
                        NavigationLink(destination: WebView(url: URL(string: urlpay)!).navigationBarBackButtonHidden(false)) {
                            Image(systemName: "arrow.right")
                            Text("Terms and condition")
                        }.padding()
                            
                        
                       

                    }
                    Section(header: Text("Actions")){
                        Toggle("Dark Appearance", isOn: $isDarkMode)
                            .onTapGesture {
                                UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = self.scheme == .dark ? .light : .dark
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color("Color")))
                        .padding()
                        
                    }
                    Section(header: Text("Sign Out")){NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }.padding()
                        
                    }
                
            }
            
           // #f2f2f2
        }.offset(y:70)
        .background(Color("ssss"))

    }}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

var languages = ["EN", "AR"]
