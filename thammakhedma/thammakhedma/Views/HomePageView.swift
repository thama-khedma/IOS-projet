//
//  HomePageView.swift
//  thammakhedma
//
//  Created by Jasser,monaem on 14/11/2022.
//

import SwiftUI

struct HomePageView: View {
    @State private var isShowingDetailView = false
    var body: some View {
                NavigationView{
            
            
                        Text("Welcome")
                        .font(.title)
                        .fontWeight(.bold)
                                                   

                
        
        .background(Color(uiColor: UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()

    }
    
}
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
