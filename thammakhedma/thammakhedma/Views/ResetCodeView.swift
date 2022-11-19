//
//  ResetCodeView.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct ResetCodeView: View {
    @State var Code:String = ""
    @State var password:String = ""
    @ObservedObject var viewModel = UserViewModel()
    @State private var Reset = false
    var body: some View {
        
        VStack(alignment: .leading ,spacing: 150){
            // Top View

                    
                    VStack( spacing: 100) {
                        Spacer()
                        
                        Text("Code")
                                .font(.callout)
                                .bold()
                                
                        TextField("Enter CODE...", text: $viewModel.code)
                                .padding()
                                .background()
                                .cornerRadius(20.0)
                        Text("new password")
                                .font(.callout)
                                .bold()
                                
                        TextField("new password...", text: $viewModel.password)
                                .padding()
                                .background()
                                .cornerRadius(20.0)
                        
                        
                        
                    }.padding([.leading,.trailing],27.5)
                    
                    
                
            HStack{	
                NavigationLink(destination: LoginView(),isActive: $Reset){
                    Button("enter",action:  {
                        viewModel.ResetCode(code: viewModel.code ,password: viewModel.password , onSuccess: {Reset = true} , onError: {
                            (errorMessage)in
                        })
                        
                    })
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    
                    // shadow...
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                    
                }
                
                
            }
            
            // Bottom View
          
                
        }
       
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()

    }
    
}

struct ResetCode_Previews: PreviewProvider {
    static var previews: some View {
        ResetCodeView()
    }
}
