//
//  ForgetView.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct ForgetView: View {
    @State var email:String = ""
    @ObservedObject var viewModel = UserViewModel()
    @State private var isShowingRegisterView = false
    var body: some View {
        GeometryReader{_ in
            VStack(alignment: .leading ){
                Image("ffffff")
                    .offset(x:40,y:70)
                VStack( spacing: 100) {
                    Text("Enter your email to recieve a password reset code")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.top, 120)
                    TextField("Enter Email", text: $viewModel.email)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color("DarkColor").opacity(0.1), radius: 5, x: 0, y: 5)
                        .shadow(color: Color("DarkColor").opacity(0.08), radius: 5, x: 0, y: -5)
                        .font(.system(size: 20))
                }
                .padding(.horizontal, 25)
                .padding(.top, 25)
                
                HStack{
                    NavigationLink(destination: ResetCodeView(),isActive: $isShowingRegisterView){
                        Button(action: {
                            viewModel.ForgetPassword(email: viewModel.email , onSuccess: {isShowingRegisterView = true} , onError: {
                                (errorMessage)in
                            })
                        })
                        {
                            
                            Text("Send")
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
                        .padding(.top, 25)
                    
                    }
                }
                
            }
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
}

struct ForgetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetView()
    }
}
