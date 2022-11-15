//
//  ForgetView.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct ForgetView: View {
    @State var email:String = ""
    
    @State private var isShowingRegisterView = false
    var body: some View {
        
        VStack(alignment: .leading ,spacing: 150){
            // Top View

                    
                    VStack( spacing: 100) {
                        Spacer()
                        
                        Text("Email")
                            .font(.title)
                            .fontWeight(.bold)
                                
                            TextField("Enter Email...", text: $email)
                                .padding()
                                .background()
                                .cornerRadius(20.0)
                        
                        
                    }.padding([.leading,.trailing],27.5)
                    
                    
                
            HStack{
                NavigationLink(destination: ResetCodeView(),isActive: $isShowingRegisterView){
                    Button("enter", action: {
                        isShowingRegisterView = true
                    })
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    
                    
                }
                
                
            }
            
            // Bottom View
            
                
        }
       
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
}

struct ForgetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetView()
    }
}
