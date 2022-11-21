//
//  SingIn:up.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct LoginView: View {
    

    var body: some View {
       
        Home()
            .preferredColorScheme(.dark)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct Home : View {
    @State private var isShowingDetailView = false
    @State var index = 0

    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{

                
                ZStack{
                    
                    SignUP(index: self.$index)
                        // changing view order...
                        .zIndex(Double(self.index))
                    
                    Login(index: self.$index)

                }
                
                HStack(spacing: 15){
                    
                    Rectangle()
                    .fill(Color("Color1"))
                    .frame(height: 1)
                    
                    Text("OR")
                    
                    Rectangle()
                    .fill(Color("Color1"))
                    .frame(height: 1)
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                // because login button is moved 25 in y axis and 25 padding = 50
                
                HStack(spacing: 25){
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("apple")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }){
                        
                        Image("fb")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("twitter")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                }
                .padding(.top, 30)
            }
            .padding(.vertical)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}

// Curve...

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // right side curve...
            
            path.move(to: CGPoint(x: rect.width, y: 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}

struct CShape2 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // left side curve...
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}
struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // left side curve...
            
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}

struct Login : View {
    
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    @State private var isShowingScanner = false
    @State private var image: Image? = Image("twitter")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var isShowingDetailView = false
    @State private var passwordforget = false
    @State private var isLogin = false
    @State private var isShowingContentView = false
    var currentUser: User?
    @State private var isShowingRegisterView = false
    @ObservedObject var viewModel = UserViewModel()
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                
                HStack{
                    
                    VStack(spacing: 10){
                        
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 30)// for top curve...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope")
                        .foregroundColor(Color("Color1"))
                        
                        TextField("Email Address", text:$viewModel.email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 190)
                
                VStack{
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash")
                        .foregroundColor(Color("Color1"))
                        
                        SecureField("Password", text:$viewModel.password)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                    
                    /*
                    EntryField(sfSymbolName: "eye.slash.fill", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)*/
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }) {
                            NavigationLink(destination: ForgetView(), isActive: $passwordforget){
                            Button("Forget Password?",action:  {
                                passwordforget = true
                                })
                                
                            }


                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                            
                        }
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                
                .padding(.horizontal)
                .padding(.top, 100)

                
            }
            .padding()
            // bottom padding...S
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
            
                self.index = 0
                    
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            // Button...
            NavigationLink(destination: profile().navigationBarBackButtonHidden(true), isActive: $isLogin){
                Button("Login", action: {
                    
                    viewModel.LogIn(email: viewModel.email, password: viewModel.password,complited: {(user ) in
                        if let  _ = user {
                           
                            print("logged in ")
                            isLogin=true
                        }else{
                            print("not loged in ")
                            isLogin=false
                        }
                    })
                    
                }
                )
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("Color1"))
                .clipShape(Capsule())
                // shadow...
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                
            }

        }
    }
}

// SignUP Page..

struct SignUP : View {
    
    @State var email = ""
    @State var username:String = ""
    @State var   password:String = ""
    @State var   lastname:String = ""
    @State private var image: Image? = Image("1")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @Binding var index : Int
    @State private var isShowingDetailView = false
    @State private var redirectLogin = false
    @ObservedObject var viewModel = UserViewModel()
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10){
                        
                        Text("SignUp")
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
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Color1"))
                        
                        TextField("First name", text: $viewModel.firstName)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Color1"))
                        
                        TextField("Last name", text: $viewModel.lastName)
                        
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    EntryField(sfSymbolName: "envelope", placeholder: "Email Address", prompt: viewModel.emailPrompt, field: $viewModel.email)
                }
                .padding(.horizontal)
                .padding(.top, 40)
                // replacing forget password with reenter password...
                // so same height will be maintained...
                
                VStack{
                    EntryField(sfSymbolName: "lock", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)
                }
                .padding(.horizontal)
                .padding(.top, 30)

                VStack{
                    EntryField(sfSymbolName: "lock", placeholder: "Confirm", prompt: viewModel.confirmPwPrompt, field: $viewModel.confirmPw, isSecure: true)
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
            NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true),isActive: $redirectLogin){
                Button("SignUp", action: {
                    viewModel.SignUp(user: User(firstname: viewModel.firstName, password:viewModel.password, email: viewModel.email, lastName: viewModel.lastName))
                    redirectLogin=true
                    
                })
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("Color1"))
                .clipShape(Capsule())
                // shadow...
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                
            }
            // moving view down..
            .offset(y: 25)
            // hiding view when its in background...
            // only button...
            .opacity(self.index == 1 ? 1 : 0)
        }
    }
}
