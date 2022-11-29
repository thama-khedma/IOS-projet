//
//  GettingStartedView.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI
import SwiftyJSON
struct GettingStartedView: View {
    @State private var isShowingDetailView = false
    @ObservedObject var viewModel = EntrepriseViewModel()

    var body: some View {
        
                NavigationView{
                    
            
        VStack{
            
            // Top View

                    
                        Spacer()
                        Image("logo")
                            .scaledToFit()
                    
                
          
            // Bottom View
                    
                  HStack {
                        
                        Spacer()
                        NavigationLink(destination: LoginView(), isActive: $isShowingDetailView){
                            Button("Get Started") {
                                
                                isShowingDetailView = true
                                print(viewModel.datas)
                            }
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(Color("Color1"))
                            .clipShape(Capsule())
                            // shadow...
                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                            
                        }
                      
                        
                    }.padding(50)
          
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()

    }
    
}}


struct GettingStartView_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedView()
    }
}
