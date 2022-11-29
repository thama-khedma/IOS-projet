//
//  test.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 27/11/2022.
//

import SwiftUI
struct PlayerView: View {
    @State var name: String
    @State var user: String
    @State var index = 0
    @State var username:String = UserViewModel.currentUser?.firstName ?? ""
    @State var  password:String =  UserViewModel.currentUser?.password ?? ""
    @ObservedObject var viewModel = UserViewModel()
    @State var   verifpassword:String=""
    @State var   lastname:String = UserViewModel.currentUser?.lastName ?? ""
    @State var  id:String =  UserViewModel.currentUser?.id ?? ""
    @State var   email:String
    
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
                                
                                Text("Company")
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
                                
                                Image(systemName: "person.3.sequence.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Company name", text: $name)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)

                        
                        VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "mail.stack.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Company Email", text: $email)
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        // replacing forget password with reenter password...
                        // so same height will be maintained...
                        

                        
                        
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
                        
                    }
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    
                    // Button...
                    .overlay(
                        RoundedRectangle(cornerRadius: 56)
                    .stroke(Color("Color1"), lineWidth: 4))
      
                    Button("update company", action: {
                        
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
            
            Spacer(minLength: 0)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
}
    struct test: View {
        @State var index = 0
        @ObservedObject var obs = EntrepriseViewModel ()
        @State var showupdate : Bool = false

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack{
                        ForEach(obs.currentlocation) { i in
                            
                                VStack{
                                    HStack(spacing: 20){
                                        ZStack(alignment: .bottom) {
                                            VStack{
                                                
                                                
                                                    HStack{
                                                        Spacer(minLength: 0)
                                                        Image(systemName: "briefcase.fill")
                                                        .foregroundColor(Color("Color1"))
                                                        Text(i.name)
                                                            .foregroundColor(self.index == 1 ? .white : .gray)
                                                            .font(.title)
                                                            .fontWeight(.bold)
                                                        
                                                        
                                                    }
                                                    
                                                
                                                .padding(.top, 30)
                                                VStack{
                                                    Button("delete", action: {
                                                        
                                                    }
                                                    )
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.vertical,5)
                                                    .padding(.horizontal, 60)
                                                    .background(Color("Color1"))
                                                    .clipShape(Capsule())
                                                    .offset(x: 0.0, y: 70)
                                                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                                    NavigationLink(destination: PlayerView(name: i.name,user: i.user,email: i.email),isActive: $showupdate) {
                                                        Button("update", action: {
                                                            showupdate = true
                                                        }
                                                        )}
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.vertical,5)
                                                    .padding(.horizontal, 60)
                                                    .background(Color.blue)
                                                    .clipShape(Capsule())
                                                    // shadow...
                                                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                                    .offset(x: 0.0, y: 70)
                                                
                                                }                                   .padding(.top, 20)
                                                

                                            }
                                            .padding()
                                            // bottom padding...
                                            .padding(.bottom, 65)
                                            .background(Color("Color2"))
                                            .clipShape(CShape1())
                                            // clipping the content shape also for tap gesture...
                                            .contentShape(CShape2())
                                            // shadow...
                                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                                            .onTapGesture {self.index = 1}
                                            .cornerRadius(35)
                                            .padding(.horizontal,4)}.overlay(
                                                RoundedRectangle(cornerRadius: 56)
                                            .stroke(Color("Color1"), lineWidth: 4))
                                    }
                                    .padding(.top,35)
                                    Spacer(minLength: 0)}
                            
                            
                        }
                    }

                    
                }.background(Color("Color").edgesIgnoringSafeArea(.all))

                .frame(height:900 )
            }
        }}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
