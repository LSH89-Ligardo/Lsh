//
//  ContentView.swift
//  UIViewControllerDemo
//
//  Created by Jungman Bae on 1/23/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var imagePickerVisible: Bool = false
    @State var selectedImage: Image? = Image(systemName: "photo")
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button(action: {
                withAnimation {
                    self.imagePickerVisible.toggle()
                }
            }, label: {
                Text("Select an Image")
            })
        }
        .padding()
        .sheet(isPresented: $imagePickerVisible) {
            MyImagePicker(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
        }
    }
}

#Preview {
    ContentView()
}
