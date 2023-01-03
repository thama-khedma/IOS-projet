//
//  CondidatureView.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 28/12/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
import RiveRuntime

struct AddToCart: View {
    @State var existedPlate : Bool = false
    @State var existedPlateIndex : Int = 0
    @State var Category : String = ""
    @State var Price : String = ""
    @State var Add_To_Cart : String = ""
    @State var Edit_Plate : String = ""
    @State var Delete_Plate : String = ""
    @State var DT : String = ""
    var body: some View{
        VStack{
            HStack(spacing: 15) {
                    Image("selectedPlate.image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                VStack(alignment: .trailing, spacing: 10, content: {
                    Text("selectedPlate.name")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("DarkColor"))
                        .multilineTextAlignment(.trailing)
                    Text("selectedPlate.category")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("GrayColor"))
                        .multilineTextAlignment(.trailing)
                    Text(String(format: "\(Price): %.2f \(DT)", "selectedPlate.price"))
                        .fontWeight(.bold)
                        .foregroundColor(Color("DarkColor"))
                })
                .padding()
            }
            .padding()
            Button(action: {
            })
            {
                Text("Add To Cart")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 70)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color.green, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            }
            .cornerRadius(15)
            .padding(.bottom, 25)
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.yellow)
                Text("Edit Plate")
                    .foregroundColor(.yellow)
            .padding(.top, 1)
            Button(action: {
            }, label: {
                Image(systemName: "delete.forward")
                    .foregroundColor(.red)
                Text("Delete Plate")
                    .foregroundColor(.red)
            }).padding(.top, 1)
        }
        .background(Color.clear.clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 35)))
    }
}
struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct DetailCondidature: View {
    @Binding var id: String
    @Binding var offre: String
    @Binding var entreprise_name: String
    @Binding var user: String
    @Binding var detail : Bool
    @State var showaddoffre : Bool = false
    @ObservedObject var viewModel = CondidatureViewModel()
    @State var index = 0

    var body: some View{
        NavigationView{
            ZStack(){
               
                VStack{
                        HStack{
                            VStack{
                                QRcodeView(offre: offre, entreprise: entreprise_name, user: user)
                                    .frame(width: 200, height: 200)
                                    .scaledToFit()
                                    .cornerRadius(20)
                            }
                            
                        }.offset(x:0,y:50)
                        .padding(.horizontal)
                        .zIndex(5)
                    // zindex sets views postion on the stack...
                    // moving bottom view up...
                    ZStack(alignment: .topLeading){
                        VStack{
                            // for phones having lesser screen size...
                            ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), showsIndicators: false) {
                                VStack{
                                    HStack(spacing: 0){
                                        Button(action: {
                                            self.index = 0
                                        }) {
                                            
                                            
                                            Text("Details")
                                                .font(.system(size: 25))
                                                .foregroundColor(Color.white)
                                                .padding(.vertical, 10)
                                                .padding(.horizontal, 25)
                                                .background(self.index == 0 ? Color("Color1") : Color.clear)
                                                .cornerRadius(8)
                                            
                                        }
                                        
                                     
                                        
                                    }
                                    if self.index == 0{ScrollView{
                                        VStack{
                                            Text("offre")
                                                .font(.title)
                                                .foregroundColor(Color.white.opacity(0.6))
                                            Text(self.offre)
                                            
                                                .font(.title)
                                                .foregroundColor(.white)
                                            Text("user email")
                                                .foregroundColor(Color.white.opacity(0.6))
                                                .padding(.top)
                                                .font(.title)
                                            Text(self.user)
                                                .font(.title)
                                                .foregroundColor(.white)
                                            HStack(spacing: 20){
                                                VStack(spacing: 12){
                                                    Text("company")
                                                        .foregroundColor(Color.white.opacity(0.6))
                                                        .padding(.top)
                                                        .font(.title)
                                                    Text(self.entreprise_name)
                                                        .font(.title)
                                                        .foregroundColor(.white)
                                                    
                                                }
                                            }
                                            .padding(.top)}.offset(y:30)
                                       
                                        VStack{/*Button(action: {
                                            showaddoffre = true
                                        }) {
                                            Text("creat offer")
                                        }
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width / 1.5)
                                        .background(Color("Color1"))
                                        
                                        */
                                            //viewModel.DeleteCondidature(id: id)
                                            Button(action: {
                                            })
                                            {
                                                Text("Accept")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.vertical)
                                                    .frame(width: UIScreen.main.bounds.width - 70)
                                                    .background(
                                                        LinearGradient(gradient: .init(colors: [Color.green, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    )
                                            }
                                            .cornerRadius(10)
                                            // shadow...
                                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                            
                                        }.offset(x:0,y:25)
                                        VStack{/*Button(action: {
                                                                  showaddoffre = true
                                                              }) {
                                                                  Text("creat offer")
                                                              }
                                                              .font(.title)
                                                              .foregroundColor(.white)
                                                              .padding(.vertical)
                                                              .frame(width: UIScreen.main.bounds.width / 1.5)
                                                              .background(Color("Color1"))
                                                              
                                                              */
                                                                  //viewModel.DeleteCondidature(id: id)
                                                                  Button(action: {
                                                                      viewModel.DeleteCondidature(id: id)
                                                                  })
                                                                  {
                                                                      Text("decline")
                                                                          .font(.system(size: 20))
                                                                          .foregroundColor(.white)
                                                                          .fontWeight(.bold)
                                                                          .padding(.vertical)
                                                                          .frame(width: UIScreen.main.bounds.width - 70)
                                                                          .background(
                                                                              LinearGradient(gradient: .init(colors: [Color.red, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                                          )
                                                                  }
                                                                  .cornerRadius(10)
                                                                  // shadow...
                                                                  .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                                                  
                                                              }.offset(x:0,y:25)
                                        
                                        
                                    
                                    }
                                    }
                                  
                                }
                                .padding(.horizontal, 25)
                            }
                            // due to bottom padding -50
                            .padding(.top, 50)
                            
                            
                        }
                        .background(Color("Color2").edgesIgnoringSafeArea(.all))
                        .clipShape(RoundShape())
                        
                    }
                    
                }
            }
            
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
struct CondidatureView : View {
   // Detail1(name: $name, id: $id, email: $email, description: $description, destination: $destination,detail: $detail)
    @Environment(\.colorScheme) var scheme
    @State var search = ""
    @State var showupdate : Bool = false
    @State var op : CGFloat = 0
    @State var refresh: Bool = false
    @State var detail = false
    @State var offre = ""
    @State var id = ""
    @State var entreprise_name = ""
    @State var user = ""
    
    @ObservedObject var CondidatureviewModel = CondidatureViewModel()
    var body: some View{
        
        VStack{
            
            ZStack{
                
                HStack(spacing: 15){
                    
                 /*   Button(action: {
                        
                    }) {
                        
                        Image(systemName:"line.horizontal.3")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primary)
                    }
                    */

                    

                }
                
                Text("Condidatures")
                    .offset(y:25)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            
            
                VStack{

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing:25){
                            ForEach(CondidatureviewModel.condidatures,id: \.self){condidature in
                ZStack(alignment: .bottom){
                                                                    Color("Color")
                                    VStack(){
                                        
                                        VStack{
                                            VStack() {
                                                
                                                QRcodeView(offre: condidature.offre, entreprise: condidature.entreprise_name, user: condidature.user)
                                                    .frame(width: 180, height: 200)
                                                    .offset(x:10)
                                                  
                                                    
                                            }
                                        }
                                    }
                                    .padding(.horizontal, -100)
                                    .padding(.vertical, 0)
                                                                }
                                                                .sheet(isPresented: $showupdate) {
                                                                  DetailCondidature(id: $id, offre: $offre, entreprise_name: $entreprise_name, user: $user, detail: $detail)
                                                                    //  AddToCart()
                                                                }
                                                                .onTapGesture {
                                                                    showupdate = true
                                            // assigning data when ever image is tapped....
                                        self.offre = condidature.offre
                                        self.entreprise_name = condidature.entreprise_name
                                        self.user = condidature.user
                                        self.id = condidature.id
                                    }
                                    
                                }}
                            
                        }
                    
                        .padding(.horizontal, 01)
                        .padding(.vertical, 50)
                    }//
                    
                
            }.refreshable{}
            .onAppear(perform: {
                CondidatureviewModel.getCondidatures(complited: {(success , respnse)in
                    if success{
                        CondidatureviewModel.condidatures = respnse!
                    }else {
                        print("error cant connect ")
                    }
                })
            
            })
        }
    }




struct CondidatureView_Previews: PreviewProvider {
    static var previews: some View {
        CondidatureView()
    }
}
