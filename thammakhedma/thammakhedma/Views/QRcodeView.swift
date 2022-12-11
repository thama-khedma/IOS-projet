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
            Form {
               /* TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)*/
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                    .padding(100)
                    .padding(.vertical,150)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: { Label("Save to Photos", systemImage: "square.and.arrow.down") }
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            /*.onChange(of: name) { _ in updateCode() }
            .onChange(of: emailAddress) { _ in updateCode() }*/
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
