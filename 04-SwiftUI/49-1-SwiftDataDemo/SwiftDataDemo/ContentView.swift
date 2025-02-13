//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Jungman Bae on 1/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var name: String = ""
    @State var quantity: String = ""
    
    @Environment(\.modelContext) private var modelContext
    @Query private var products: [Product]

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button(action: {
                        addProduct()
                    }, label: {
                        Text("Add")
                    })
                    Spacer()
                    NavigationLink(destination: ResultsView(name: name)) {
                        Text("Find")
                    }
                    Spacer()
                    Button(action: {
                        name = ""
                        quantity = ""
                    }, label: {
                        Text("Clear")
                    })
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                List {
                    ForEach(products) { product in
                        NavigationLink {
                            Text("Product at \(product.name ?? "Not Found")")
                        } label: {
                            HStack {
                                Text(product.name ?? "Not Found")
                                Spacer()
                                Text(product.quantity ?? "Not Found")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Products")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    private func addProduct() {
        withAnimation {
            let newItem = Product(name: name, quantity: quantity)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(products[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}
