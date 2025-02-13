//
//  ContentView.swift
//  ImageDocDemo
//
//  Created by Jungman Bae on 1/16/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @Binding var document: ImageDocDemoDocument
    @State private var ciFilter = CIFilter.sepiaTone()
    
    let context = CIContext()

    var body: some View {
        VStack {
            Image(uiImage: document.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Button(action: {
                filterImage()
            }, label: {
                Text("Filter Image")
            })
            .padding()
        }
    }
    
    func filterImage() {
        print("filter!")
        ciFilter.intensity = Float(1.0)
        
        let ciImage = CIImage(image: document.image)
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = ciFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            document.image = UIImage(cgImage: cgImage)
        }
    }
}

#Preview {
    ContentView(document: .constant(ImageDocDemoDocument())) 
}
