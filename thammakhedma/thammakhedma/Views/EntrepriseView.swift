//
//  EntrepriseView.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 28/11/2022.
//

import SwiftUI

struct EntrepriseView: View {
    
    @State var name: String
    @State var selectedImage: UIImage?
    @State var showImagePicker : Bool = false
    @State private var shouldPresentImagePicker = false

    var body: some View {
        ZStack(alignment: .leading){
            
            
            VStack{
                
                HStack{
                    if let selectedImage = selectedImage {
                        Image(uiImage:selectedImage) .resizable()
                            .cornerRadius(7)
                            .padding(1) // Width of the border
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(10)
                            .clipShape(Circle())
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .offset(x:3,y:40)
                    }
                    HStack {
                        Image(systemName: "camera").font(.system(size: 40, weight:.medium)).foregroundColor(Color(uiColor: UIColor(red: 0.88, green: 0.85, blue: 0.77, alpha: 1))).onTapGesture {
                            self.showImagePicker = true
                        }.offset(x:5,y:50)}.onChange(of: self.selectedImage)
                    { newVal in
                        self.selectedImage = newVal
                    }.onAppear
                    {
                        self.selectedImage = nil
                    }
                    Spacer(minLength: 0)
                    
                  
                    
                }
                .padding(.top, 30)// for top curve...
                
            }
            .padding()
        }.frame(alignment: .leading).sheet(isPresented: $showImagePicker)
        {
            
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            
        }
    }
}

struct EntrepriseView_Previews: PreviewProvider {
    static var previews: some View {
        EntrepriseView(name: "John")
    }
}
