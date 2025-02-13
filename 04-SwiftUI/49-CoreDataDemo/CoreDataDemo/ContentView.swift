//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Jungman Bae on 1/16/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var name: String = ""
    @State var quantity: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Product.entity(), sortDescriptors: [])
    private var products: FetchedResults<Product>

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
                    NavigationLink(destination: ResultsView(name: name, viewContext: viewContext)) {
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
                        HStack {
                            Text(product.name ?? "Not found")
                            Spacer()
                            Text(product.quantity ?? "Not found")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    private func addProduct() {
        withAnimation {
            let newProduct = Product(context: viewContext)
            newProduct.name = name
            newProduct.quantity = quantity
            saveContext()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                offset in
                products[offset]
            }.forEach({
                element in
                viewContext.delete(element)
            })
//          offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
