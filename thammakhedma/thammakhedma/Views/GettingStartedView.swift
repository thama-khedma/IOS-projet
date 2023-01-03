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
    @State var animation = false
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
                        .fontWeight(.regular)
                        .padding(.vertical , 12)
                        .lineLimit(200)
                        .padding(.horizontal, 100)
                        .background(.ultraThinMaterial, in: Capsule())
                        .clipShape(Capsule())
                        .navigationBarBackButtonHidden(true)
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                }.offset(y:240)
                    
                
                
            }
        }
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("Log")
                .offset(x:-10,y:-50)
            Text("Thama khedma")
                
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color .gray)
                .offset(x:160,y:-80)
                .lineLimit(200)
            
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
