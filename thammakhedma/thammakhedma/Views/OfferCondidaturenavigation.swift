//
//  OfferCondidaturenavigation.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 2/1/2023.
//

import SwiftUI

struct OfferCondidaturenavigation: View {
    
    @State var goTo1 = false
    @State var goTo2 = false

    var body: some View {
        VStack{
            Text("JOBS")
            
            
            NavigationLink(destination: offerView(),isActive: $goTo1){
            Button(action: {
                goTo1=true
            })
            {
                Text("JOBS offers")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 200)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                
            }}
            .cornerRadius(8)
            .padding(.horizontal, 25)
            .padding(.top, 25)
            
            
            
            
            NavigationLink(destination: CondidatureView(),isActive: $goTo2){
                Button(action: {
                    goTo2=true
                })
                {
                    Text("JOB Applications")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 200)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    
                }
                .cornerRadius(8)
                .padding(.horizontal, 25)
                
            }}

    }
}

struct OfferCondidaturenavigation_Previews: PreviewProvider {
    static var previews: some View {
        OfferCondidaturenavigation()
    }
}
