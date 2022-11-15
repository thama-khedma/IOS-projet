//
//  profile.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct profile: View {
    var body: some View {
        
        Home1()
            .preferredColorScheme(.dark)
    }}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        profile()
    }
}

struct Home1 : View {
    
    @State var index = 0
    @State var email = ""
    @State var pass = ""
    @State private var isShowingScanner = false
    @State private var image: Image? = Image("twitter")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var isShowingDetailView = false
    @State private var passwordforget = true
    @ObservedObject var viewModel = UserViewModel()
    var body: some View{
        
        VStack{
            
            HStack(spacing: 15){

            }
            .padding()
            
            HStack{
                
                VStack(spacing: 0){
                    
                    Rectangle()
                    .fill(Color("Color"))
                    .frame(width: 80, height: 3)
                    .zIndex(1)
                    
                    
                    // going to apply shadows to look like neuromorphic feel...
                    
                    Image("profile")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 6)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 8)
                    .background(Color("Color"))
                    .cornerRadius(10)
                    
                }
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Text("name")
                        .font(.title)
                        .foregroundColor(Color.black.opacity(0.8))
                    

                    Text("reply.kavsoft@gmail.com")
                        .foregroundColor(Color.black.opacity(0.7))
                }
                .padding(.leading, 20)
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
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
                                
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("First name", text: $viewModel.firstName)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Last name", text: $viewModel.lastName)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                        
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Email Address", text: $viewModel.email)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                        // replacing forget password with reenter password...
                        // so same height will be maintained...
                        
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                SecureField("Password", text: $viewModel.password)
                            }
                            
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                        
                    }
                    .padding()
                    // bottom padding...
                    .padding(.bottom, 65)
                    .background(Color("Color2"))
                    .clipShape(CShape1())
                    // clipping the content shape also for tap gesture...
                    .contentShape(CShape1())
                    // shadow...
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                    .onTapGesture {
                    
                        
                        self.index = 1
                        
                    }
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    
                    // Button...
                    
      
                        Button("update profile", action: {
// here to add update action
                        })
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .background(Color("Color1"))
                        .clipShape(Capsule())
                        // shadow...
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                        
                    
                    // moving view down..
                    .offset(y: 25)
                    // hiding view when its in background...
                    // only button...
                    .opacity(self.index == 1 ? 1 : 0)
                }
            }
            .padding(.top,20)
            
            
            Spacer(minLength: 0)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}
