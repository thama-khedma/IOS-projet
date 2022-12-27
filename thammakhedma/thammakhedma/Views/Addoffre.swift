//
//  Addoffre.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 11/12/2022.
//

import SwiftUI

struct Addoffre: View {
    @State var name = ""
    @State var description = ""
    @State var entreprise : String
    @State var user = UserViewModel.currentUser?.id ?? ""
    @State var index = 0
    @State private var isShowingScanner = false
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State private var isShowingDetailView = false
    @State private var passwordforget = false
    @State private var isOffre = false
    @State private var isShowingContentView = false
    @State var detail : Bool = false
    var currentUser: User?
    @State private var isShowingRegisterView = false
    @ObservedObject var viewModel = OffreViewModel()
    var body: some View{
        NavigationView{
            ZStack(alignment: .bottom) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(spacing: 10){
                            
                            Text("Add offre")
                                .font(.system(size: 25))
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 25)
                                .background( Color("Color1"))
                                .cornerRadius(8)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 30)// for top curve...
                    VStack{
                        
                        HStack(){
                            Image(systemName: "person.3.sequence.fill")
                                .foregroundColor(Color("Color1"))
                            Text(entreprise)
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        
                       
                       
                    }
                   
                    VStack{
                        
                        HStack(spacing: 15){
                            TextField("offre name", text:$name)
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                    }
                    .padding(.horizontal)
                    .padding(.top, 190)
                    
                    VStack{
                        HStack(spacing: 15){
                            TextField("offre description", text:$description)
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                        
                        /*
                         EntryField(sfSymbolName: "eye.slash.fill", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)*/
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    HStack{
                        
                    }
                    
                    .padding(.horizontal)
                    .padding(.top, 150)
                    
                    
                }
                .padding()
                // bottom padding...S
                .padding(.bottom, 65)
                .background(Color("Color2"))
                .clipShape(CShape2())
                .contentShape(CShape2())
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                .onTapGesture {
                    
                    self.index = 0
                    
                }
                .cornerRadius(35)
                .padding(.horizontal,20)
                
                // Button...
                NavigationLink(destination: offerView().navigationBarBackButtonHidden(true), isActive: $isOffre){
                    Button("Add Offre", action: {
                        isOffre=true
                        viewModel.AddOffre(name: self.name, description: self.description, entreprise: self.entreprise, userid: self.user)
                        
                    }
                    )
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background(Color("Color1"))
                    .cornerRadius(10)
                    // shadow...
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                }
                .preferredColorScheme(.dark)
            }
        }
    }
}
struct Addoffre_Previews: PreviewProvider {
    static var previews: some View {
        Entreprises()
    }
}
