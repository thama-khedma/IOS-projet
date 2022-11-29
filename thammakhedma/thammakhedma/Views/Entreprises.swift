//
//  Entreprises.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 25/11/2022.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct Entreprises: View {
    
    var body: some View {
        
        Home3()
    }
}

struct Entreprises_Previews: PreviewProvider {
    static var previews: some View {
        Entreprises()
    }
}

struct Card : Identifiable {
    var id : String
    var name : String
    var email : String
    var user : String
    var expand : Bool
}




struct Home3: View {
    @State var jasser = [Card]()
    @State var data = [Card]()
    @ObservedObject var obs = EntrepriseViewModel()
    @State var hero = false
    var body: some View{
        
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Friday, May 2020")
                            
                            Text("Today")
                                .font(.title)
                                .fontWeight(.bold)
                        }.onAppear{
                            print(obs.datas)
                            data = obs.datas
                            
                        }
                        
                        Spacer()
                        
                        Image("pic")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Capsule())
                    }.onAppear{
                        print("aaaaaa",obs.datas)
                        
                    }
                    
                    .padding()
                    
                    VStack(spacing: 15){
                        
                        // going to implement hero animation...
                        // were going to use geometry reader to get the postiton of the card...
                        
                        ForEach(0..<self.data.count){i in
                            
                            GeometryReader{g in
                                
                                CardView(data: self.$data[i], hero: self.$hero)
                                
                                // going to move view up how its down from top...
                                    .offset(y: self.data[i].expand ? -g.frame(in: .global).minY : 0)
                                
                                // going to hide all other views when a view is expanded...
                                    .opacity(self.hero ? (self.data[i].expand ? 1 : 0) : 1)
                                // you can see still scrollview is working so were going to disable it...
                                // follow me...
                                
                                    .onTapGesture {
                                        
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                                            
                                            if !self.data[i].expand{
                                                
                                                // opening only one time then close button will work...
                                                self.hero.toggle()
                                                self.data[i].expand.toggle()
                                            }
                                        }
                                        
                                    }.onAppear{
                                        print("aaaaaa",obs.datas)
                                        
                                    }
                                
                            }.onAppear{
                                print("aaaaaa",obs.datas)
                                
                            }
                            // going to increase height based on expand...
                            .frame(height: self.data[i].expand ? UIScreen.main.bounds.height : 250)
                            
                            // 500 for disabling the drag for scrollview...
                            .simultaneousGesture(DragGesture(minimumDistance: self.data[i].expand ? 0 : 500).onChanged({ (_) in
                                
                                print("dragging")
                            }))
                        }
                    }
                }
                
            }
        }
        NavigationView {
            List(obs.datas) { i in
                NavigationLink(destination: PlayerView(name: i.name,user: i.user,email: i.email)) {
                    ZStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color("Color2"))
                            .background(Color("Color2"))
                            .frame(height: 100)
                        VStack(alignment: .leading){
                            Text(i.name)
                                .foregroundColor(.white)
                                .font(.title)
                                .background(Color("Color2"))
                        }.onAppear{
                            print(obs.datas)

                        }
                        .padding()
                        
                    }
                    .padding()
                    
                   
                }
            }.onAppear{
                print("zzzzzz",obs.datas)

            }
            
        }
    }
    
}

// card View...

struct CardView : View {
    
    @Binding var data : Card
    @Binding var hero : Bool
    
    var body: some View{
        
        
        // going to implement close button...
        
        ZStack(alignment: .topTrailing){
            
            VStack{
                
                Image(self.data.name)
                .resizable()
                .frame(height: self.data.expand ? 350 : 250)
                .cornerRadius(self.data.expand ? 0 : 25)
                
                if self.data.expand{
                    
                    HStack{
                        
                        Text(self.data.user)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Text(self.data.email)
                        .padding(.horizontal)
                    
                    HStack{
                        
                        Text("Details")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack(spacing: 0){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("mcard1")
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("mcard2")
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("mcard3")
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            
                        }) {
                            
                            Image("mcard4")
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Let's Go")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .background(LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                    }
                    .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 15)
                }
            }
            .padding(.horizontal, self.data.expand ? 0 : 20)
            // to ignore spacer scroll....
            .contentShape(Rectangle())
            
            // showing only when its expanded...
            
            if self.data.expand{
                
                Button(action: {
                   
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                        
                        self.data.expand.toggle()
                        self.hero.toggle()
                    }
                    
                }) {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .clipShape(Circle())
                    
                }
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.trailing,10)
            }
        }
    }
}

// sample Data..


