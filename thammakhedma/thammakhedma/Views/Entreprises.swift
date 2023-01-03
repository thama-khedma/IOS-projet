//
//  Entreprises.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 25/11/2022.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import RiveRuntime
import MapKit
struct PlayerView: View {
    @State var name: String
    @State var index = 0
    @ObservedObject var viewModel = EntrepriseViewModel()
    @State var   id:String
    @State var   email:String
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
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "mail.stack.fill")
                                    .foregroundColor(Color("Color1"))
                                Text(id)
                                TextField("Company description", text: $description)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                        Button("update company", action: {
                            viewModel.updateEntreprise(name: name, email: email, description: description, id:id)
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
                        Button("Delete company", action: {viewModel.DeleteEntreprise(id: id)})
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
                    .cornerRadius(20)
                    .padding(.horizontal,20)
                    
                    // Button...
                    
      

                }
            }
            .padding(.top,35)
            
            Spacer(minLength: 0)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
}
struct Furniture : Identifiable,Hashable{
    var id : String
    var image : String
    var name : String
    var email : String
    var description : String
    var destination : String
}

var furnitures = [[Furniture]]()
/*            .onAppear{furnitures.append([Furniture(id: 0, image: "r11", title: "Grey Chair", price: "$500")])}

*/


struct Entreprises: View {
    init(){
        getEntrepriss(complited: {(success , respnse)in
            if success{
                let furnitures = respnse!
            }else {
                print("error cant connect ")
            }
        })
    }
    func getEntrepriss(complited: @escaping(Bool, [[Furniture]]?) -> Void) {
        AF.request(Statics.URL+"/Entreprise/find/139.7867190434941/35.72192853727322", method: .get ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    furnitures = []
                    for i in JSON(response.data!){
                        furnitures.append([Furniture(id:i.1["_id"].stringValue, image: i.1["image"].stringValue,name: i.1["name"].stringValue, email: i.1["email"].stringValue,description: i.1["description"].stringValue,destination: i.1["adresse"].stringValue)])
                        /*furnitures.append([Furniture(id:i.1["_id"].stringValue, image: "r11",name: i.1["name"].stringValue, email: i.1["email"].stringValue, description: "description")])*/
                    }
                    complited(true,furnitures)
                    
                case let .failure(error):
                    
                    debugPrint(error)
                    
                complited(false,nil)
                    
                }
            }
        
    }
    @State var show = false
    @State var isOpen = false
    @AppStorage("selectedMenu") var selectedMenu: SelectedMenu = .search
   /* var button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoplay: false, animationName: "open")*/
    @State var detail = false
    @State var name = ""
    @State var id = ""
    @State var email = ""
    @State var description = ""
    @State var destination = ""
    @State var image = ""

    var body: some View {
        
        ZStack {
            
          SideMenu()
                .padding(.top, 50)
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
                .ignoresSafeArea(.all, edges: .top)
            ZStack{
                    switch selectedMenu {
                    case .home:
                        ZStack{//detail: self.$detail
                            Detail1(name: $name, id: $id, image: $image, email: $email, description: $description, destination: $destination,detail: $detail)
                            // expanding view when ever detail view is tapped...
                                .frame(width: self.detail ? nil : 100, height: self.detail ? nil : 100)
                                .opacity(self.detail ? 1 : 0)
                            TabView2(name: $name, id: $id, image: $image, email: $email, description: $description, destination: $destination,detail: $detail)
                                .opacity(self.detail ? 0 : 1)
                        }.animation(.default)
                        // for changing status bar color...
                        .preferredColorScheme(self.detail ? .dark : .light)
                            .safeAreaInset(edge: .top) {
                                Color.clear.frame(height: 104)
                            }
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
                            .offset(x: isOpen ? 265 : 0)
                            .scaleEffect(isOpen ? 0.9 : 1)
                            .scaleEffect(show ? 0.92 : 1)
                            .ignoresSafeArea()
                    case .search:
                        
                        OfferCondidaturenavigation()
                            .safeAreaInset(edge: .top) {
                                Color.clear.frame(height: 104)
                            }
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
                            .offset(x: isOpen ? 265 : 0)
                            .scaleEffect(isOpen ? 0.9 : 1)
                            .scaleEffect(show ? 0.92 : 1)
                            .ignoresSafeArea()
                    case .favorites:
                        AddEntreprise()
                            .safeAreaInset(edge: .top) {
                                Color.clear.frame(height: 104)
                            }
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
                            .offset(x: isOpen ? 265 : 0)
                            .scaleEffect(isOpen ? 0.9 : 1)
                            .scaleEffect(show ? 0.92 : 1)
                            .ignoresSafeArea()
                    case .help:
                        Settings()
                            .safeAreaInset(edge: .top) {
                                Color.clear.frame(height: 104)
                            }
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
                            .offset(x: isOpen ? 265 : 0)
                            .scaleEffect(isOpen ? 0.9 : 1)
                            .scaleEffect(show ? 0.92 : 1)
                            .ignoresSafeArea()
                    case .history:
                        Text("chat")
                    case .notifications:
                        Text("chat")
                    case .darkmode:
                        Text("chat")
                    }
                
        }

                        
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    isOpen.toggle()}
            }) {
                
                Image(systemName:"line.horizontal.3")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.primary)
            }
                .frame(width: 44, height: 44)
                .mask(Circle())
                .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: 640, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0)
                .onChange(of: isOpen) { newValue in
                    if newValue {
                        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                    } else {
                        UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                    }
                }
        }
        
    }
}
struct TabView2 : View {
    
    @AppStorage("selectedTab") var selectedTab: Tab = .bell
    @State var index = 0
    @Environment(\.colorScheme) var scheme
    @State var show = false
    @State var isOpen = false
    @Binding var name: String
    @Binding var id: String
    @Binding var image: String
    @Binding var email: String
    @Binding var description: String
    @Binding var destination: String
    @Binding var detail : Bool
    var body: some View{
        
        VStack(){
            
    
           
            ZStack{
                switch selectedTab {
                case .chat:
                    Ent(name: self.$name, id: self.$id,image: self.$image, email: self.$email,  destination: self.$destination,description: self.$description, detail: self.$detail)
                case .search:
                    AddEntreprise()
                case .timer:
                    offerView()
                case .bell:
                    OfferCondidaturenavigation()
                case .user:
                    Settings()
                    
                        .preferredColorScheme(.dark)
                }
                
                
        }
               
                        
                    
                    
                }
        TabBar()
        .offset(y:-18)
               .background(
                   LinearGradient(colors: [Color("Background").opacity(0), Color("Background")], startPoint: .top, endPoint: .bottom)
                       .frame(height: 150)
                       .frame(maxHeight: .infinity, alignment: .bottom)
                       .allowsHitTesting(false)
               )
               .ignoresSafeArea()
               .offset(y: isOpen ? 300 : 0)
               .offset(y: show ? 200 : 0)
            }
            
        }
   
struct RoundShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 45, height: 45))
        
        return Path(path.cgPath)
    }
}

struct Detail1 : View {
    @Binding var name: String
    @Binding var id: String
    @Binding var image: String
    @Binding var email: String
    @Binding var description: String
    @Binding var destination: String
    @Binding var detail : Bool
    @State var showaddoffre : Bool = false
    @ObservedObject var viewModel = EntrepriseViewModel()
    @State var index = 0
    var body: some View{
        NavigationView{
            ZStack{
                Color.black.edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                       
                            
                    }.offset(y:100)
                    HStack{
                        MapView2(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
                        
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(width: 260, height: 200)
                            .offset(y:100)
                        Button(action: {
                            // closing the detail view when close button is pressed...
                            self.detail.toggle()
                        }) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(Color("Color1"))
                                .padding(.horizontal)
                            
                        }.offset(x:-166,y:100)
                    }.offset(x:30,y:-50)
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
                                        
                                        Button(action: {
                                            self.index = 1
                                            
                                        }) {
                                            Text("Description")
                                                .font(.system(size: 25))
                                                .foregroundColor(Color.white)
                                                .padding(.vertical, 10)
                                                .padding(.horizontal, 25)
                                                .background(self.index == 1 ? Color("Color1") : Color.clear)
                                                .cornerRadius(8)
                                            
                                        }
                                        Spacer()
                                    }
                                    if self.index == 0{ScrollView{
                                        VStack{
                                            Text("adress")
                                                .font(.title)
                                                .foregroundColor(Color.white.opacity(0.6))
                                            Text(self.destination)
                                            
                                                .font(.title)
                                                .foregroundColor(.white)
                                            Text("email")
                                                .foregroundColor(Color.white.opacity(0.6))
                                                .padding(.top)
                                                .font(.title)
                                            Text(self.email)
                                                .font(.title)
                                                .foregroundColor(.white)
                                            HStack(spacing: 20){
                                                VStack(spacing: 12){
                                                    Text("description")
                                                        .foregroundColor(Color.white.opacity(0.6))
                                                        .padding(.top)
                                                        .font(.title)
                                                    Text(self.description)
                                                        .font(.title)
                                                        .foregroundColor(.white)
                                                    
                                                }
                                            }
                                            .padding(.top)}.offset(y:30)
                                        NavigationLink(destination: Addoffre(entreprise: self.name), isActive: $showaddoffre){
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
                                                Button("Add offre", action: {
                                                    showaddoffre = true
                                                    
                                                }
                                                       
                                                       
                                                )
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .padding(.vertical)
                                                .frame(width: UIScreen.main.bounds.width / 1.2)
                                                .background(Color("Color1"))
                                                .cornerRadius(10)
                                                // shadow...
                                                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                                
                                            }}.offset(x:0,y:70)
                                    }
                                    }
                                    else{
                                        
                                        
                                        
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
                                        VStack{
                                            HStack(spacing: 15){
                                                Image(systemName: "mail.stack.fill")
                                                    .foregroundColor(Color("Color1"))
                                                //Text(id)
                                                TextField("Company description", text: $description)
                                            }
                                            Divider().background(Color.white.opacity(0.5))
                                        }
                                        .padding(.horizontal)
                                        .padding(.top, 60)
                                        Button("update company", action: {
                                            self.index = 0
                                            viewModel.updateEntreprise(name: name, email: email, description: description, id:id)
                                        })
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width / 1.2)
                                        .background(Color("Color1"))
                                        .cornerRadius(10)
                                        // shadow...
                                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                        .offset(y: 25)
                                        .opacity(self.index == 1 ? 1 : 0)
                                        Button("Delete company", action: {detail = false
                                            viewModel.DeleteEntreprise(id: id)})
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width / 1.2)
                                        .background(Color("Color1"))
                                        .cornerRadius(10)
                                        // shadow...
                                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                            .offset(y: 25)
                                            .opacity(self.index == 1 ? 1 : 0)
                                        
                                        
                                        // Button...
                                        
                                        
                                        
                                        
                                        
                                        
                                    }//////////////
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
        }
    }
}
struct Detail : View {
    @State var name: String
    @State var id: String
    @State var email: String
    @State var description: String
    @State var destination: String
    @State var showupdate : Bool = false
    @State var showaddoffre : Bool = false
    @State var refresh: Bool = false
    var body : some View{
        NavigationView{
            VStack(spacing: 8){
                GeometryReader{geo in
                    VStack(alignment: .leading){
                       
                                HStack{
                                    VStack(alignment: .leading, spacing: 12){
                                        
                                        Text(name).fontWeight(.bold)
                                            .font(.title)
                                            .foregroundColor(.white)
                                    }.padding()
                                    Spacer()
                                    }
                          
                            VStack(alignment: .leading, spacing: 15){
                                

                                HStack(spacing: 5){
                                    Text("destination : ").fontWeight(.heavy)
                                    Text(destination).foregroundColor(.gray)
                                }.offset(x:30,y:180)
                                
                                HStack(spacing: 5){
                                    Text("contact : ").fontWeight(.heavy)
                                    
                                    Text(email).foregroundColor(.gray).fontWeight(.bold)
                                }.offset(x:30,y:90)
                                
                                
                                /* HStack(spacing: 6){
                                 
                                 ForEach(0..<5){i in
                                 
                                 Button(action: {
                                 
                                 }) {
                                 Text("\(i + 1)").foregroundColor(.white).padding(20)
                                 }.background(Color("bg"))
                                 .cornerRadius(8)
                                 }
                                 }*/
                            }.padding(.horizontal,15)
                            
                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    Text("Description : ").fontWeight(.heavy)
                                    Text(description).foregroundColor(.gray)
                                }.offset(x:-130,y:-220)
                                    NavigationLink(destination: PlayerView(name: name,id: id,email:email,description: description), isActive: $showupdate)
                                {
                                    HStack(spacing: 8){
                                        
                                        Button(action: {
                                            showupdate = true
                                            refresh = true
                                        }) {
                                                Image(systemName: "gear.circle")
                                                    .resizable()
                                                    .frame(width: 50.0, height: 50.0)
                                                    
                                            }.background(Color("Color"))
                                              
                                            
                                        }.padding(.top, 6)
                                       
                                    }
                                .background(Color("Color"))
                            }.background(Color("Color")).padding()
                            .offset(x:160,y:380)
                            NavigationLink(destination: Addoffre(entreprise: name), isActive: $showaddoffre){
                                    VStack{
                                        Button("Add offre", action: {showaddoffre = true}
                                        )
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical)
                                        .padding(.horizontal, 50)
                                        .background(Color("Color1"))
                                        .clipShape(Capsule())
                                        // shadow...
                                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                    }}.offset(x:110,y:200)

                        
                    }
                    
                }.background(Color("Color"))
                    .padding(.top, -75)
                
            }
        }
    }
}
/*struct opact : View {
    @State var detail = false
    @State var name: String
    @State var id: String
    @State var email: String
    @State var description: String
    @State var destination: String
    var body: some View{
        ZStack{//detail: self.$detail
            Detail1(name: "", id: "", email: "", description: "", destination: "",detail: self.$detail)
            // expanding view when ever detail view is tapped...
                .frame(width: self.detail ? nil : 100, height: self.detail ? nil : 100)
                .opacity(self.detail ? 1 : 0)
            TabView2(detail: self.$detail)
                .opacity(self.detail ? 0 : 1)
        }.animation(.default)
        // for changing status bar color...
        .preferredColorScheme(self.detail ? .dark : .light)
    }
}*/
struct Ent : View {
    
    @Environment(\.colorScheme) var scheme
    @State var search = ""
    @State var showupdate : Bool = false
    @Binding var name : String
    @Binding var id : String
    @Binding var image : String
    @Binding var email : String
    @State var op : CGFloat = 0
    @Binding var destination : String
    @Binding var description : String
    @State var refresh: Bool = false
    @Binding var detail : Bool
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
                    Spacer()
                    
                    Button(action: {
                        CondidatureviewModel.getCondidatures(complited: {(success , respnse)in
                            if success{
                                CondidatureviewModel.condidatures = respnse!
                            }else {
                                print("error cant connect ")
                            }
                        })
                        print(CondidatureviewModel.condidatures)
                    }) {
                        
                        Image("qr")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primary)
                    }
                    
                   
                }
                
                Text("Companies")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    VStack{
                        Rectangle()
                            .fill(Color("Color1"))
                            .frame(height: 2)
                        
                    }.offset(y:25)
                    HStack{
                        
                        Text("Recommended For You")
                            .fontWeight(.bold)
                            .font(.title)
                            .offset(x:40)
                        Spacer()
                    }
                    .padding(.top,30)
                    .padding(.bottom, 20)
                    VStack{
                        Rectangle()
                            .fill(Color("Color1"))
                            .frame(height: 2)
                        
                    }.offset(y:-20)
                    //
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:25){
                            ForEach(furnitures,id: \.self){furniture in
                                HStack(){
                                    ForEach(furniture){i in
                                       /* Button(action: {
                                            self.showupdate.toggle()
                                            self.name = i.name
                                            self.id = i.id
                                            self.email = i.email
                                            self.destination=i.destination
                                            self.description=i.description
                                            
                                        }) {*/
                                            ZStack(){
                                                Color("Color")
                                                    .frame(height: UIScreen.main.bounds.height / 2.5)
                                                    .cornerRadius(20)
                                                VStack(){
                                                    
                                                    MapView2(coordinate: CLLocationCoordinate2D(latitude: 139.7867190434941, longitude: 35.72192853727322))
                                                        .scaledToFit()
                                                        .cornerRadius(20)
                                                        .frame(width: 260, height: 200)
                                                    HStack{
                                                        VStack(alignment: .leading, spacing: 12) {
                                                            VStack{
                                                                Image("map")
                                                            }.offset(x:35,y:30)
                                                            Text(i.destination)
                                                                .fontWeight(.bold)
                                                                .offset(x:60,y:0)
                                                                
                                                            Text(i.name)
                                                                .fontWeight(.bold)
                                                                .font(.title)
                                                                .offset(x:90,y:0)
                                                            
                                                            
                                                        }
                                                        .foregroundColor(.white)
                                                        Spacer(minLength: 0)
                                                       
                                                    }
                                                    
                                               
                                                }
                                                .padding(.horizontal)
                                                .padding(.vertical, 40)
                                                .padding(.bottom)
                                                
                                              
                                            }
                                        
                                       // }
                                            .onTapGesture {
                                        self.detail.toggle()
                                        self.showupdate.toggle()
                                        self.name = i.name
                                        self.id = i.id
                                        self.email = i.email
                                        self.image = i.image
                                        self.destination=i.destination
                                        self.description=i.description
                                            }
                                        
                                     
                                    }}
                                }}
                      
                            
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 25)
                        .opacity(10)
                    }//
                    
                
            }.refreshable{ getEntrepriss(complited: {(success , respnse)in
                if success{
                     furnitures = respnse!
                }else {
                    print("error cant connect ")
                }
            })
              
            }
            .onAppear(perform: {
                getEntrepriss(complited: {(success , respnse)in
                    if success{
                         furnitures = respnse!
                    }else {
                        print("error cant connect ")
                    }
                })
                
            
            })
            Spacer()
        }
    }
    func getEntrepriss(complited: @escaping(Bool, [[Furniture]]?) -> Void) {
        AF.request(Statics.URL+"/Entreprise/find/139.7867190434941/35.72192853727322", method: .get ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    furnitures = []
                    for i in JSON(response.data!){
                        furnitures.append([Furniture(id:i.1["_id"].stringValue, image: i.1["image"].stringValue,name: i.1["name"].stringValue, email: i.1["email"].stringValue,description: i.1["description"].stringValue,destination: i.1["adresse"].stringValue)])
                        /*furnitures.append([Furniture(id:i.1["_id"].stringValue, image: "r11",name: i.1["name"].stringValue, email: i.1["email"].stringValue, description: "description")])*/
                    }
                    complited(true,furnitures)
                case let .failure(error):
                    debugPrint(error)
                complited(false,nil)
                    
                }
            }
    }
}


struct Entreprises_Previews: PreviewProvider {
    static var previews: some View {
        Entreprises()
    }
}
