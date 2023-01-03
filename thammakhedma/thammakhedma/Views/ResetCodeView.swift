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
        
        VStack(alignment: .leading ,spacing: 200){
            // Top View

                    
                    VStack( spacing: 50) {
                            Image("Codereset")
                        Text("Code")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                                
                        TextField("Enter CODE...", text: $viewModel.code)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)

                            .font(.system(size: 20))
                        Text("new password")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                                
                        TextField("new password...", text: $viewModel.password)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)

                            .font(.system(size: 20))
                        
                        
                        
                    }.padding(.horizontal, 25)
                    
                
            HStack{	
                NavigationLink(destination: LoginView(),isActive: $Reset){
                    Button(action: {
                        viewModel.ResetCode(code: viewModel.code ,password: viewModel.password , onSuccess: {Reset = true} , onError: {
                            (errorMessage)in
                        })
                    })
                    {
                        Text("Reset Password")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .background(
                                Color("Color1")
                                //LinearGradient(gradient: .init(colors: [Color("PrimaryColor"), Color("LightColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )

                    }
                    .cornerRadius(8)
                    .padding(.horizontal, 25)
                    .padding(.top, -140)
                    
                }
                
                
            }
            
            // Bottom View
          
                
        }
       
        .background(Color("Color").edgesIgnoringSafeArea(.all))
       

    }
    
}

struct ResetCode_Previews: PreviewProvider {
    static var previews: some View {
        ResetCodeView()
    }
}
