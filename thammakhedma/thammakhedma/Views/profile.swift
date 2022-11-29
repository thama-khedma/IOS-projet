//
//  profile.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct profile: View {
    var body: some View {
        TabView{
            Home1()
                .preferredColorScheme(.dark)
                .tabItem (){
                    Image(systemName: "person.text.rectangle")
                }
            Home2()
                .preferredColorScheme(.dark)
                .tabItem (){
                    Image(systemName: "mappin.and.ellipse")
                }
            test()
                .preferredColorScheme(.dark)
                .tabItem (){
                    Image(systemName: "building.2.crop.circle.fill")
                }
        }
        
    }
}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        profile()
    }
}

struct Home1 : View {
    @State var index = 0
    @State var username:String = UserViewModel.currentUser?.firstName ?? ""
    @State var  password:String =  UserViewModel.currentUser?.password ?? ""
    @ObservedObject var viewModel = UserViewModel()
    @State var   verifpassword:String=""
    @State var   lastname:String = UserViewModel.currentUser?.lastName ?? ""
    @State var  id:String =  UserViewModel.currentUser?.id ?? ""
    @State var   email:String = UserViewModel.currentUser?.email ?? ""
    @State var  description:String = ""
    @State var selectedImage: UIImage?
    @State var showImagePicker : Bool = false
    @State var update : Bool = false
    @State var isdisabledEmail : Bool = true
    @State var activateSecurePwd : Bool = false
    @State var logout : Bool = false
    var body: some View{
        
        
        VStack{
            
            HStack(spacing: 15){
            }
            .padding()
            .onAppear{
                
            }
            // Tab Items...
            // Cards...
            HStack(spacing: 20){

                ZStack(alignment: .bottom) {
                    
                    VStack{
                        
                        HStack{
                            
                            Spacer(minLength: 0)
                            
                            VStack(spacing: 10){
                                
                                Text("profile")
                                    .foregroundColor(self.index == 1 ? .white : .gray)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Capsule()
                                    .fill(self.index == 1 ? Color.blue : Color.clear)
                                    .frame(width: 100, height: 5)
                            }
                        }
                        .padding(.top, 30)// for top curve...

                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("First name", text: $username)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "person.circle")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Last name", text: $lastname)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Email Address", text: $email)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        // replacing forget password with reenter password...
                        // so same height will be maintained...
                        
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                SecureField("Password", text: $password)
                            }
                            
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        
                        
                    }
                    .padding()
                    // bottom padding...
                    .padding(.bottom, 65)
                    .background(Color("Color2"))
                    .clipShape(CShape2())
                    // clipping the content shape also for tap gesture...
                    .contentShape(CShape2())
                    // shadow...
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                    .onTapGesture {
                    
                        
                        self.index = 1
                        
                    }.overlay(
                        RoundedRectangle(cornerRadius: 56)
                    .stroke(Color("Color1"), lineWidth: 4))
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    
                    // Button...
                    
      
                    Button("update profile", action: {                                     UserViewModel.currentUser?.email = email
                        UserViewModel.currentUser?.firstName = username
                        UserViewModel.currentUser?.lastName = lastname
                        UserViewModel.currentUser?.password = password
                        
                        viewModel.updateUser(user: UserViewModel.currentUser!)
                        })
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .background(Color("Color1"))
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    .offset(y: 25)
                    .opacity(self.index == 1 ? 1 : 0)
                }
            }
            .padding(.top,35)
            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true),isActive: $logout ){
                Button{
                    UserViewModel.currentUser = nil
                    logout=true}label:{Text("LOG OUT")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        
                        .background(Color("Color2"))
                        .clipShape(Capsule())
                        // shadow...
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                        
                    
                    // moving view down..
                    .offset(y: 25)
                    // hiding view when its in background...
                    // only button...
                    .opacity(self.index == 1 ? 1 : 0)}
            
            
            
            
            
        }
            
            Spacer(minLength: 0)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}
