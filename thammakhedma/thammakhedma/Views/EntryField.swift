//
//  EntryField.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 21/11/2022.
//

import SwiftUI

struct EntryField: View {
    var sfSymbolName: String
    var placeholder: String
    var prompt: String
    @Binding var field: String
    var isSecure = false
    @State var visible = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(Color("Color1"))
                if isSecure {
                    HStack(spacing: 15){
                        
                        VStack{
                            
                            if self.visible{
                                
                                TextField(placeholder, text: $field)
                                    .autocapitalization(.none)
                            }
                            else{
                                
                                SecureField(placeholder, text: $field)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            visible.toggle()
                        }) {
                            
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        }
                        
                    }
                } else {
                    TextField(placeholder, text: $field)
                }
                
            }
            Divider().background(Color.white.opacity(0.5))
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }

    }
    
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(sfSymbolName: "eye.slash.fill", placeholder: "Email Address", prompt: "Enter a valid email address", field: .constant(""))
    }
}
