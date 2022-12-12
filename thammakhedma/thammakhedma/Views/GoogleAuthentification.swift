//
//  GoogleAuthentification.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 12/12/2022.
//

import Foundation
import SwiftUI
import UIKit
struct GoogleAuthentification: View {
    var body: some View {
        //GettingStartedView(show: .constant(true))
        
            storyboardview()
        
        }
    }
struct GoogleAuthentification_Previews: PreviewProvider {
    static var previews: some View {
      //  GettingStartedView(show: .constant(true))
        GoogleAuthentification()
    }
}
struct storyboardview: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    func makeUIViewController(context content: Context) -> UIViewController{
        let storyboard = UIStoryboard (name: "Main", bundle: Bundle.main)
        
        let controller = storyboard.instantiateViewController (identifier: "Google")
        return controller
    }
}

