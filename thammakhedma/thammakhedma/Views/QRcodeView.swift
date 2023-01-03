//
//  QRcodeView.swift
//  thammakhedma
//
//  Created by Monaem Hmila on 10/12/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct QRcodeView: View {
    @State var offre : String
    @State var entreprise : String
    @State var user : String
    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationView {
                Image(uiImage: qrCode)
            
                    .resizable()
                    .interpolation(.none)
                    
            
            .onAppear(perform: updateCode)
        }
    }

    func updateCode() {
        qrCode = generateQRCode(from: "\(offre)\n\(entreprise)\n\(user)")
        
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QRcodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRcodeView(offre: "offre", entreprise: "entreprise", user: "user")
    }
}
