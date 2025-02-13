//
//  TodoRowView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI

struct TodoRowView: View {
    let todo: TodoItem
    let showCategory: Bool
    
    init(todo: TodoItem, showCategory: Bool = true) {
        self.todo = todo
        self.showCategory = showCategory
    }
    
    @State private var showingEditView: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                .foregroundStyle(todo.isCompleted ? .green : .gray)
            VStack(alignment: .leading) {
                Text(todo.title)
                    .strikethrough(todo.isCompleted)
                if let dueDate = todo.dueDate {
                    Text(dueDate, format: Date.FormatStyle(date: .numeric, time: .standard))
                        .font(.caption)
                        .foregroundStyle(dueDate > Date.now ? .gray : .red)
                }
            }
            Spacer()
            if showCategory,
               let category = todo.category {
                Text(category.name ?? "-")
                    .font(.caption)
                    .padding(4)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 4))
            }
            PriorityBadge(priority: todo.priority)
        }
        .onTapGesture {
            todo.isCompleted.toggle()
        }
        .onLongPressGesture(minimumDuration: 0.5) {
            showingEditView = true
        }
        .swipeActions(edge: .leading) {
            NavigationLink(value: TodoNavigation.detail(todo)) {
                Text("Detail")
            }
            .tint(.yellow)
        }
        .sheet(isPresented: $showingEditView) {
            // EditTodoView 안에서 빠진 NavigationStack 을 추가함
            // ( 팝업일 경우 네비게이션 바 제목을 출력하려면, 독립적인 NavigationStack 따로 필요함 )
            NavigationStack {
                EditTodoView(todo: todo)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            TodoRowView(todo: TodoItem(title: "Hello, world!", dueDate: Date().addingTimeInterval(1000),
                                       category: Category(name: "업무")))
        }
        .navigationTitle("Todo List")
    }
}
