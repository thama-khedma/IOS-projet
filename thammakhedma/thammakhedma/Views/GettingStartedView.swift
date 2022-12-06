//
//  GettingStartedView.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI
import RiveRuntime

struct GettingStartedView: View {
    @State var showModal = false
    @Binding var show: Bool
    @State private var nextpage = false
    var body: some View {
        NavigationView{
            ZStack {
                Color("Color").ignoresSafeArea()
                    .opacity(showModal ? 0.4 : 0)
                
                content
                    .offset(y: showModal ? -50 : 0)
                
                NavigationLink(destination: LoginView(), isActive: $nextpage){
                    Button("Login", action: {nextpage = true})
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 50)
                        .background(Color("Color"))
                        .clipShape(Capsule())
                        .navigationBarBackButtonHidden(true)
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                }
                
                
            }
        }
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Thamma Khedma ?")
                .font(.custom("Poppins Bold", size: 60))
                .frame(width: 260, alignment: .leading)

            
            Spacer()
            

            

        }
        .padding(40)
        .padding(.top, 40)
        .background(
            RiveViewModel(fileName: "shapes").view()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .blur(radius: 30)
                .blendMode(.hardLight)
        )
        .background(
            Color("Color")
                .blur(radius: 50)
        )
    }}


struct GettingStartView_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedView(show: .constant(true))
    }
}
