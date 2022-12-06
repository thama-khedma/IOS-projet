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
                                TextField("Company description", text: $description)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
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
        print("ahyaaaaa",furnitures)
    }
    func getEntrepriss(complited: @escaping(Bool, [[Furniture]]?) -> Void) {
        AF.request(Statics.URL+"/entreprise/", method: .get ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<500)
            .validate(contentType: ["application/json"])
            .responseData {
                response in
                switch response.result {
                case .success:
                    furnitures = []
                    for i in JSON(response.data!){
                        furnitures.append([Furniture(id:i.1["_id"].stringValue, image: "main",name: i.1["name"].stringValue, email: i.1["email"].stringValue,description: i.1["description"].stringValue,destination: i.1["adresse"].stringValue)])
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
    @AppStorage("selectedMenu") var selectedMenu: SelectedMenu = .home

   /* var button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoplay: false, animationName: "open")*/
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
                        TabView2()
                            
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
                        offerView()
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
                        offer()
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
                        Text("chat")
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
                    isOpen.toggle()
                }
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
    

    @State var index = 0
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        VStack(spacing: 0){
            
            ZStack{
                
                Ent()
                    .opacity(self.index == 0 ? 1 : 0)

                
                offerView()
                    .opacity(self.index == 1 ? 1 : 0)
                
                
                
                profile()
                    .opacity(self.index == 3 ? 1 : 0)
                
            }
            
           
            HStack{
                
                Button(action: {
                    
                    self.index = 0
                    
                }) {
                    
                    HStack(spacing: 6){
                     
                        Image("home")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(self.index == 0 ? .white : .primary)
                        
                        if self.index == 0{
                            
                            Text("Home")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.vertical,3)
                    .padding(.horizontal)
                    .background(self.index == 0 ? Color("Color1") : Color.clear)
                    .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    self.index = 1
                    
                }) {
                    
                    HStack(spacing: 6){
                     
                        Image("search")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(self.index == 1 ? .white : .primary)
                        
                        if self.index == 1{
                            
                            Text("Search")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.vertical,3)
                    .padding(.horizontal)
                    .background(self.index == 1 ? Color("Color1") : Color.clear)
                    .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
                
                
                Button(action: {
                    
                    self.index = 3
                    
                }) {
                    
                    HStack(spacing: 6){
                     
                        Image("account")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(self.index == 3 ? .white : .primary)
                        
                        if self.index == 3{
                            
                            Text("Account")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.vertical,3)
                    .padding(.horizontal)
                    .background(self.index == 3 ? Color("Color1") : Color.clear)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal,25)
            .padding(.vertical,1)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 10 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(self.scheme == .dark ? Color("Color2") : Color("Color"))
            .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 5, y: -5)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
struct Detail : View {
    @State var name: String
    @State var id: String
    @State var email: String
    @State var description: String
    @State var destination: String
    @State var showupdate : Bool = false

    var body : some View{
       
            VStack(spacing: 8){
                
                Image("main").resizable().aspectRatio(1, contentMode: .fill).frame(width:UIScreen.main.bounds.width,height: 500).offset(y: -200).padding(.bottom, -200)
                
                GeometryReader{geo in
                    
                    VStack(alignment: .leading){
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            HStack{
                                
                                VStack(alignment: .leading){
                                    
                                    Text(name).fontWeight(.heavy).font(.largeTitle)
                                    
                                    
                                }
                                
                                Spacer()
                                
                                Text("$299").foregroundColor(Color("Color")).font(.largeTitle)
                            }
                            
                        }.padding()
                        ScrollView{
                            VStack(alignment: .leading, spacing: 15){
                                
                                
                                HStack(spacing: 5){
                                    
                                    Image("map").renderingMode(.original)
                                    Text(destination).foregroundColor(Color("Color"))
                                    
                                }
                                
                                HStack(spacing : 8){
                                    
                                    ForEach(0..<5){_ in
                                        
                                        Image(systemName: "star.fill").font(.body).foregroundColor(.yellow)
                                    }
                                }
                                
                                Text("contact").fontWeight(.heavy)
                                
                                Text(email).foregroundColor(.gray)
                                
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
                                
                                Text("Description").fontWeight(.heavy)
                                Text(description).foregroundColor(.gray)
                                NavigationView{
                                    NavigationLink(destination: PlayerView(name: name,user: id,email:email,description: description), isActive: $showupdate){
                                        HStack(spacing: 8){
                                            
                                            Button(action: {
                                                showupdate = true
                                            }) {
                                                
                                                Image(systemName: "gear.circle")
                                                    .resizable()
                                                    .frame(width: 50.0, height: 50.0)
                                                
                                            }
                                            
                                        }.padding(.top, 6)
                                    }}
                            }.padding()
                        }
                    }
                    
                }.background(Color("Color"))
                    .padding(.top, -75)
                
            }
        
    }
}
struct Cart : View {
    
    var body: some View{
        
        VStack{
            
            Text("Cart")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Search : View {
    var body: some View{
        
        VStack{
            
            Text("Search")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Account : View {
    var body: some View{
        
        VStack{
            
            Text("Account")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Ent : View {

    @Environment(\.colorScheme) var scheme
    @State var search = ""
    @State var showupdate : Bool = false
    @State var name : String = ""
    @State var id : String = ""
    @State var email : String = ""
    @State var op : CGFloat = 0
    @State var destination : String = ""
    @State var description : String = ""

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
                        
                    }) {
                        
                        Image("qr")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        
                        
                        UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = self.scheme == .dark ? .light : .dark
                        
                    }) {
                        
                        Image(systemName: self.scheme == .dark  ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 22))
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
                    

                    
                    HStack{
                        
                        Text("Best to pick")
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Spacer()
                    }
                    .padding(.top,22)
                    
                    VStack{
                        Image("main")
                        .resizable()
                        .frame(width: 360, height: 200)
                        Text("SpaceX")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding(.top,-30)
                        Text("Astrophysics")
                            .foregroundColor(.gray)
                            .padding(.top,8)
                            .padding(.bottom)
                    }
                    .background(
                        Color.primary.opacity(0.06)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .cornerRadius(25)
                            .padding(.top,10)
                    )
                    .padding(.top,25)
                    
                    HStack{
                        
                        Text("Recommended For You")
                            .fontWeight(.bold)
                            .font(.title)
                        Spacer()
                    }
                    .padding(.top,30)
                    .padding(.bottom, 20)
                    
                    ForEach(furnitures,id: \.self){furniture in
                        
                        HStack(){
                            
                            ForEach(furniture){i in
                                Button(action: {
                                    self.showupdate.toggle()
                                    self.name = i.name
                                    self.id = i.id
                                    self.email = i.email
                                    self.destination=i.destination
                                    self.description=i.description
                                    print(name,destination,description)
                                }) {
                                    VStack{
                                        Image(i.image)
                                            .resizable()
                                            .frame(width: 400, height: 200)
                                        
                                        
                                        Text(i.name)
                                            .fontWeight(.bold)
                                        
                                        Text(i.email)
                                            .padding(.top, 6)
                                            .sheet(isPresented: $showupdate) {
                                                Detail(name:self.name,id:self.id,email:self.email,description:self.description,destination:self.destination)}
                                    }
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .offset(x: self.op)
                                    .background(Color.primary.opacity(0.06))
                                    .cornerRadius(10)
                                }
                                
                            }
                            
                        }
                    }
                    
                }
                .padding()
            }
            
            Spacer()
        }
    }
}


struct Entreprises_Previews: PreviewProvider {
    static var previews: some View {
        Entreprises()
    }
}
