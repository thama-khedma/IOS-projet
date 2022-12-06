//
//  OnboardingView.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 1/12/2022.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    @State var showModal = false
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color("Color").ignoresSafeArea()
                .opacity(showModal ? 0.4 : 0)
            
            content
                .offset(y: showModal ? -50 : 0)
            

            
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color("Color"))
                    .frame(width: 36, height: 36)
                    .background(.black)
                    .mask(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .offset(y: showModal ? -200 : 80)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Find A job")
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
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true))
    }
}
