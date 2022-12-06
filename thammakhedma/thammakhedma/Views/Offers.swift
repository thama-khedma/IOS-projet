//
//  Offers.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 4/12/2022.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct offerdata : Identifiable {
    
    var id : String
    var image : String
    var name : String
    var description : String
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
                         data.append(offerdata(id: i.1["_id"].stringValue, image: "g3", name: i.1["name"].stringValue, description: i.1["description"].stringValue))
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
struct offreDetail : View {
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

                            }.padding()
                        }
                    }
                    
                }.background(Color("Color"))
                    .padding(.top, -75)
                
            }
        
    }
}
struct offer : View {
    
    // for sticky header view...
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    @State var show = false
    @Environment(\.colorScheme) var scheme

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
                        
                        HStack{
                            
                            Text("job Offers")
                                .font(.title)
                                .fontWeight(.bold)
                                .offset(x:50,y:0)
                            Spacer()
                            
                            Button(action: {
                                
                                
                                UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = self.scheme == .dark ? .light : .dark
                                
                            }) {
                                
                                Image(systemName: self.scheme == .dark  ? "sun.max.fill" : "moon.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        VStack(spacing: 20){
                            ForEach(data){i in
                                CardView(data: i)
                            }
                        }
                        .padding(.top)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            )
            

        })
        .edgesIgnoringSafeArea(.top)
    }
}

// CardView...

struct CardView : View {
    
    var data : offerdata
    @State var showupdate : Bool = false
    var body: some View{
        
        HStack(alignment: .top, spacing: 20){
            
            Image(self.data.image)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(self.data.name)
                    .fontWeight(.bold)
                
                Text(self.data.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    
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
                        offreDetail(name:self.data.name,id:self.data.id,email:self.data.description,description:self.data.description,destination:"self.destination")}
                    Text("In-App\nPurchases")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer(minLength: 0)
        }
    }
}



