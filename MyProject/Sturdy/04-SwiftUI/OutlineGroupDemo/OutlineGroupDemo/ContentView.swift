//
//  ContentView.swift
//  OutlineGroupDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(carItems) { carItem in
                Section(header: Text(carItem.name)) {
                    OutlineGroup(carItem.children ?? [CarInfo](),
                                 children: \.children) { child in
                        CellView(item: child)
                    }
                }
            }
        }
        .listStyle(InsetListStyle())
    }
}

#Preview {
    ContentView()
}

struct CellView: View {
    var item: CarInfo
    
    var body: some View {
        HStack {
            Image(systemName: item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.green)
            Text(item.name)
        }
    }
}
