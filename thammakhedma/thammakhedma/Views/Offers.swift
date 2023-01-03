//
//  Offers.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 4/12/2022.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import MapKit

struct offerdata : Identifiable {
    
    var id : String
    var image : String
    var name : String
    var description : String
    var entreprise_name : String
}

var data = [offerdata]()

struct offerView: View {
    

    init(){
        
         getoffer(complited: {(success , respnse)in
             if success{
                 let data = respnse!
             }else {
                 print("error cant connect ")
             }
             
         })
         print("ahyaaaaa",data)
        
     }
     
     func getoffer(complited: @escaping(Bool, [offerdata]?) -> Void) {
         AF.request(Statics.URL+"/offre/offre", method: .get ,encoding: JSONEncoding.default)
             .validate(statusCode: 200..<500)
             .validate(contentType: ["application/json"])
             .responseData {
                 response in
                 switch response.result {
                 case .success:
                     data = []
                     for i in JSON(response.data!){
                         data.append(offerdata(id: i.1["_id"].stringValue, image: "g3", name: i.1["name"].stringValue, description: i.1["description"].stringValue,entreprise_name: i.1["entreprise"].stringValue))
                     }
                     complited(true,data)
                 case let .failure(error):
                     debugPrint(error)
                 complited(false,nil)
                 }
             }
     }
    var body: some View {
        offer()
    }
}

struct offerView_Previews: PreviewProvider {
    static var previews: some View {
        offerView()
    }
}

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
                
            }
            .scaledToFit()
            
            .frame(width: 200, height: 200)
            
    }
}
struct LandmarkDetail: View {

    var body: some View {
        VStack {

            VStack(alignment: .leading) {
                Text("landmark.name")
                    .font(.title)

                HStack {
                    Text("landmark.park")
                    Spacer()
                    Text("landmark.state")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \("landmark.name")")
                    .font(.title2)
                Text("landmark.description")
            }
            .padding()

            Spacer()
        }
    }
}


struct offreDetail : View {
    @State var name: String
    @State var id: String
    @State var email: String
    @State var description: String
    @State var userid: String = UserViewModel.currentUser?.email ?? ""
    @State var entreprise_name:String
    @State var showupdate : Bool = false
    @State var apply : Bool = false
    @ObservedObject var viewModel = CondidatureViewModel()
    var body : some View{
        NavigationView{
            VStack {
                MapView2(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
               Image("Joob")
                   
                    .scaledToFit()
                    .offset(y:-70)
                    .frame(width: 100, height: 100)
                
                .offset(y: -130)
                .padding(.bottom, -130)
                VStack(alignment: .leading) {
                    Text("offer")
                        .font(.title)
                    
                    HStack {
                        Text(name)
                        Spacer()
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("About \(name)")
                        .font(.title2)
                    Text(description)
                    
                }
                .padding()
                  NavigationLink(destination: UpdateOfferView(name: name,id: id,description: description), isActive: $showupdate){
                    Button(action: {
                        showupdate=true
                    }) {
                        
                        Image(systemName: "gear.circle") .resizable()
                            .frame(width: 50.0, height: 50.0)
                    }
                }.offset(y:80)
                NavigationLink(destination: QRcodeView(offre: name, entreprise: entreprise_name, user: userid), isActive: $apply){
                    Button(action: {
                    apply=true
                        viewModel.AddCondidature(entreprise_name: entreprise_name, offre_decription: description, user: userid, offre: name)
                    }) {
                        
                        HStack(spacing: 6){
                            Text("apply for the offer")
                            Image("arrow").renderingMode(.original)
                        }.foregroundColor(.white)
                            .padding()
                        
                    }.background(Color("Color"))
                    .cornerRadius(8)}.offset(y:100)
                Spacer()
            }/*
            VStack{
                GeometryReader{geo in
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                VStack(alignment: .leading){
                                    Text("name").fontWeight(.heavy).font(.largeTitle)
                                    Text(name).fontWeight(.heavy).font(.largeTitle)
                                }.padding()
                                Spacer()
                            }
                        }.padding()
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Description").fontWeight(.heavy)
                            Text(description).foregroundColor(.gray)
                            HStack(spacing: 8){
                                NavigationLink(destination: UpdateOfferView(name: name,id: id,description: description), isActive: $showupdate){
                                    Button(action: {
                                        showupdate=true
                                    }) {
                                        
                                        Image(systemName: "gear.circle") .resizable()
                                            .frame(width: 50.0, height: 50.0)
                                    }
                                }
                                NavigationLink(destination: QRcodeView(offre: name, entreprise: entreprise_name, user: userid), isActive: $apply){
                                    Button(action: {
                                    apply=true
                                        viewModel.AddCondidature(entreprise_name: entreprise_name, offre_decription: description, user: userid, offre: name)
                                    }) {
                                        
                                        HStack(spacing: 6){
                                            Text("apply for the offer")
                                            Image("arrow").renderingMode(.original)
                                        }.foregroundColor(.white)
                                            .padding()
                                        
                                    }.background(Color("Color"))
                                        .cornerRadius(8)
                                    
                                }.padding(.top, 6)
                            }
                        }.padding()
                    }
                }.background(Color("Color"))
                    .padding(.top, -75)
            }*/
        }
    }
}
struct offer : View {
    @State var searchQuery = ""
    // for sticky header view...
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    @State var show = false
    @Environment(\.colorScheme) var scheme
    
    @Namespace var animation
    init(){
        
         getoffer(complited: {(success , respnse)in
             if success{
                 let data = respnse!
             }else {
                 print("error cant connect ")
             }
             
         })
        
     }
     
     func getoffer(complited: @escaping(Bool, [offerdata]?) -> Void) {
         AF.request(Statics.URL+"/offre/offre", method: .get ,encoding: JSONEncoding.default)
             .validate(statusCode: 200..<500)
             .validate(contentType: ["application/json"])
             .responseData {
                 response in
                 switch response.result {
                 case .success:
                     data = []
                     for i in JSON(response.data!){
                         data.append(offerdata(id: i.1["_id"].stringValue, image: "g3", name: i.1["name"].stringValue, description: i.1["description"].stringValue,entreprise_name: i.1["entreprise"].stringValue))
                     }
                     complited(true,data)
                 case let .failure(error):
                     debugPrint(error)
                 complited(false,nil)
                 }
             }
     }
    var body: some View{
        
        ZStack(alignment: .top, content: {

            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    // now going to do strechy header....
                    // follow me...
                    
                    GeometryReader{g in
                        
                        

                        
                    }
                    // fixing default height...
                    .frame(height: UIScreen.main.bounds.height / 8.0)
                        
                    VStack{
                        HStack(spacing: 15) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 23, weight: .bold))
                                .foregroundColor(Color.gray)

                            TextField("Search", text: $searchQuery)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(8)
                        .padding()

                        HStack{

                            Text("job Offers")
                                .font(.title)
                                .fontWeight(.bold)
                                .offset(x:50,y:0)
                            Spacer()
                            
                          
                        }.padding(.horizontal,-20)
                        
                        VStack(spacing: 20){

                            ForEach(searchQuery == "" ? data : data.filter{$0.name.lowercased().contains(searchQuery.lowercased())}){i in
                                CardView(data: i, animation: animation)
                            }
                        }.onAppear(perform: {
                            getoffer(complited: {(success , respnse)in
                                if success{
                                    let data = respnse!
                                }else {
                                    print("error cant connect ")
                                }
                                
                            })
                            
                        
                        })
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            ).refreshable {
                getoffer(complited: {(success , respnse)in
                    if success{
                        let data = respnse!
                    }else {
                        print("error cant connect ")
                    }
                    
                })
            }
            

        })
        .edgesIgnoringSafeArea(.top)
    }
    
}
struct UpdateOfferView: View {
    @State var name: String
    @State var index = 0
    @ObservedObject var viewModel = OffreViewModel()
    @State var   id:String
    @State var   description:String
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
                        VStack{
                            HStack(){
                                Image(systemName: "person.3.sequence.fill")
                                    .foregroundColor(Color("Color1"))
                                TextField("Company name", text: $name)
                               
                            }
                            Divider().background(Color.white)
                        }
                        .padding(.horizontal,20)
                        .padding(.top, 60)
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "mail.stack.fill")
                                
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Company offre", text: $description)
                                
                            }
                            Divider().background(Color.white)
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        Button("update offre", action: {
                            viewModel.updateOffre(name: name,description: description,id: id)
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
                        Button("Delete offre", action: {viewModel.DeleteOffre(id: id)})
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
                    self.index = 1 }
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    
                    // Button...
                    
      

                }.offset(y:100)
            }
            .padding(.top,35)
            
            Spacer(minLength: 0)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
}
// CardView...

struct CardView : View {
    
    var data : offerdata
    @State var showupdate : Bool = false
    
    var animation: Namespace.ID

    var body: some View{
        
            
        HStack(spacing: 15){
            
            Image("Joob")

                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .offset(x:10)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
               Text(self.data.name)
                    .fontWeight(.bold)
                    .offset(x:80)
              
                
                Text(self.data.description)
                    .font(.caption)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .offset(x:80,y:20)
                HStack(spacing: 12){
                    
                    /*
                     Button(action: {
                        self.showupdate.toggle()

                    }) {
                        
                        Text("Details")
                            .fontWeight(.bold)
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                            // for adapting to dark mode...
                            .background(Color.primary.opacity(0.06))
                            .clipShape(Capsule())
                    }
                    .sheet(isPresented: $showupdate) {
                        offreDetail(name:self.data.name,id:self.data.id,email:self.data.description,description:self.data.description, entreprise_name: self.data.entreprise_name)
                    }
                    */
                }
                .sheet(isPresented: $showupdate) {
                    offreDetail(name:self.data.name,id:self.data.id,email:self.data.description,description:self.data.description, entreprise_name: self.data.entreprise_name)
                }
                

            })
            
            .padding(.vertical,30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Spacer(minLength: 0)
                    }.onTapGesture {
                        self.showupdate.toggle()
                    }
               
                    .offset(x:40,y:2)
        VStack{
            Rectangle()
                .fill(Color("Color1"))
                .frame(height: 2)
            
            }.offset(x:30)
      
        .background(
            Color.white
                .opacity(0)
                .ignoresSafeArea()
        )
        .cornerRadius(80)
        
        .padding(.horizontal,-40)
        

        
    }
}



