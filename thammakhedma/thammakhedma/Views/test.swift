//
//  test.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 27/11/2022.
//

import SwiftUI
import RiveRuntime

struct testView: View {
    @State var show = false
    @State var isOpen = false
  
    var body: some View {
        ZStack {
            
          SideMenu()
                .padding(.top, 50)
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
                .ignoresSafeArea(.all, edges: .top)
            
            TabView2()
                
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(height: 104)
                }
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0), perspective: 1)
                .offset(x: isOpen ? 265 : 0)
                .scaleEffect(isOpen ? 0.9 : 1)
                .scaleEffect(show ? 0.92 : 1)
                .ignoresSafeArea()
                        
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    isOpen.toggle()
                }
            }) {
                
                Image(systemName:"line.horizontal.3")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.primary)
            }
                .frame(width: 44, height: 44)
                .mask(Circle())
                .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: 700, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0)
                .onTapGesture {
                    
                }
                .onChange(of: isOpen) { newValue in
                    if newValue {
                        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                    } else {
                        UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                    }
                }
            
 
        }
    }
}

extension UIViewController {
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = style == .lightContent ? UIColor.black : .white
            statusBar.setValue(style == .lightContent ? UIColor.white : .black, forKey: "foregroundColor")
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
