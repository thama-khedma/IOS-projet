//
//  EntrepriseLocation.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 26/11/2022.
//



struct EntrepriseLocation_Previews: PreviewProvider {
    static var previews: some View {
        EntrepriseLocation()
    }
}

import SwiftUI
import MapKit
import CoreLocation
struct EntrepriseLocation: View {
    @State private var isShowingDetailView = false
    var body: some View {
        Home5()
            .preferredColorScheme(.dark)
}
}


struct Home5 : View {
    @State var index = 0
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!
    @State var name = ""
    @State var distance = ""
    @State var longitud = ""
    @State var latitud = ""
    @State var show = false
    @State var loading = false
    @State var book = false
    @State var doc = ""
    @State var data : Data = .init(count: 0)
    @State var search = false
    @State var next : Bool = false
    @State var selectedImage: UIImage?
    @State private var shouldPresentImagePicker = false
    @State private var image: Image? = Image("1")
    @State var showImagePicker : Bool = false
    @State private var isShowingRegisterView = false
    @ObservedObject var viewModel = EntrepriseViewModel()
    @State var  id:String =  UserViewModel.currentUser?.id ?? ""
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .bottom){
                
                VStack(spacing: 0){
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text(self.destination != nil ? "Destination" : "Pick a Location")
                                .font(.title)
                            
                            if self.destination != nil{
                                
                                Text(self.name)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            
                            self.search.toggle()
                            
                        }) {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color("Color"))
                        }
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color("Color"))
                    
                    MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination, name: self.$name,distance: self.$distance,longitud: $longitud,latitud: $latitud,
                            show: self.$show)
                    .onAppear {
                    
                        self.manager.requestAlwaysAuthorization()
                            
                    }
                }
                
                if self.destination != nil && self.show{
                    
                    ZStack(alignment: .topTrailing){
                        
                        VStack(spacing: 20){
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
                                        TextField("company name", text: $viewModel.name)
                                    }
                                    
                                    Divider().background(Color.white.opacity(0.5))
                                }
                                .padding(.horizontal)
                                .padding(.top, 60)
                                VStack{
                                    
                                    HStack(spacing: 15){
                                        
                                        
                                        
                                        TextField("company Email", text: $viewModel.email)
                                    }
                                    
                                    Divider().background(Color.white.opacity(0.5))
                                }
                                .padding(.horizontal)
                                .padding(.top, 60)
                                VStack{
                                    HStack(spacing: 15){
                                        TextField("description", text: $viewModel.description)
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
                            NavigationLink(destination: Entreprises().navigationBarBackButtonHidden(true),isActive: $next ){
                                Button(action: {print("aaaa"+viewModel.name+viewModel.email+id+viewModel.description+String(self.name))
                                    /*viewModel.image(name: viewModel.name, email: viewModel.email, id:id, adresse: String(self.name), description: viewModel.description, latitud: String(self.longitud), longitud: String(self.latitud), image: selectedImage!)*/
                                    viewModel.AddEntreprise(name: viewModel.name, email: viewModel.email, id:id, adresse: String(self.name), description: viewModel.description, latitud: String(self.longitud), longitud: String(self.latitud))
                                     next = true
                                }) {
                                    
                                    
                                    Text("Creat Location")
                                        .foregroundColor(Color("Color2"))
                                        .padding(.vertical, 10)
                                        .frame(width: UIScreen.main.bounds.width / 2)
                                }
                                
                                .background(Color("Color1"))
                                .clipShape(Capsule())
                                
                            }
                            
                        }
                        

                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .background(Color("Color"))
                }
            }
            if self.loading{
                Loader()
            }
        }.frame(alignment: .leading).sheet(isPresented: $showImagePicker)
        {
            
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert) { () -> Alert in
            Alert(title: Text("Error"), message: Text("Please Enable Location In Settings !!!"), dismissButton: .destructive(Text("Ok")))
        }
    }
    
}
