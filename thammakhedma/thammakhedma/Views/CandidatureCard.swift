//
//  CandidatureCard.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 27/12/2022.
//
import SwiftUI

struct CandidatureCard: View {
    
    @State var offre : String
    @State var entreprise : String
    @State var user : String
    var body: some View {
       
        VStack(alignment: .leading, spacing: 8) {
            
            Text(offre)
                .font(.title)
                .foregroundColor(Color.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .layoutPriority(1)
            Text(entreprise)
                .font(.title)
                .opacity(0.7)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(user)
                .font(.title)
                .opacity(0.7)
                .padding(.horizontal, 25)
            Spacer()
            QRcodeView(offre: offre, entreprise: entreprise, user: user)
                .frame(width: 260, height: 250)
        }
        .foregroundColor(.white)
        .frame(width: 260, height: 400)
        .background(.linearGradient(colors: [Color.black.opacity(1), Color.black.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
        /*.overlay(
            Image("Topic 1")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
        )*/
    }
}
struct CandidatureCard_Previews: PreviewProvider {
    static var previews: some View {
        CandidatureCard(offre: "offre", entreprise: "entreprise", user: "user")
    }
}
