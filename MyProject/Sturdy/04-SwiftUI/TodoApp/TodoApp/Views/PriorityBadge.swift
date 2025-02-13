//
//  PriorityBadge.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/21/25.
//

import SwiftUI

struct PriorityBadge: View {
    let priority: Priority
    
    var body: some View {
        Text(priority.title)
            .font(.caption)
            .padding(4)
            .background(backgroundColor)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 4))
    }
    
    private var backgroundColor: Color {
        switch priority {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}

#Preview {
    PriorityBadge(priority: TodoItem(title: "Hello, world!").priority)
}
