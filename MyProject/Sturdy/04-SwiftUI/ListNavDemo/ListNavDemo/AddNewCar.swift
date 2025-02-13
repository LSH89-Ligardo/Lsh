//
//  AddNewCar.swift
//  ListNavDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import SwiftUI

struct AddNewCar: View {
    var carStore: CarStore
    @Binding var path: NavigationPath
    
    @State private var isHybrid: Bool = false
    @State private var name: String = ""
    @State private var description: String = ""
    
    
    var body: some View {
        Form {
            Section(header: Text("Car Details")) {
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                DataInput(title: "Model", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                
                Toggle(isOn: $isHybrid) {
                    Text("Hybrid").font(.headline)
                }
                .padding()
            }
            
            Button(action: addNewCar) {
                Text("Add Car")
            }
        }
    }
    
    func addNewCar() {
        let newCar = Car(id: UUID().uuidString,
                         name: name,
                         description: description,
                         imageName: "tesla_model_3",
                         isHybrid: isHybrid)
        carStore.cars.append(newCar)
        path.removeLast()
    }
}

struct DataInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
