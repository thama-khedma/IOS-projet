//
//  EntrepriseView.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 28/11/2022.
//

import SwiftUI

struct EntrepriseView: View {
    
    @State var name: String
    
    
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color("Color2"))
                .frame(height: 100)
            VStack(alignment: .leading){
                Text(name)
                    .foregroundColor(.white)
                    .font(.title)
            }
            .padding()
        }
        .padding()
    }
}

struct EntrepriseView_Previews: PreviewProvider {
    static var previews: some View {
        EntrepriseView(name: "John")
    }
}
