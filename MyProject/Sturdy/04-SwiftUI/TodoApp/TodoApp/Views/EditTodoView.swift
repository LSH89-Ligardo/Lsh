//
//  EditTodoView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI
import SwiftData

struct EditTodoView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Query private var categories: [Category]
    
    let todo: TodoItem
    
    @State private var title: String = ""
    @State private var priority: Priority
    @State private var dueDateEnabled = false
    @State private var dueDate: Date? = nil
    @State private var selectedCategory: Category?
    
    init(todo: TodoItem) {
        self.todo = todo
        self._title = State(initialValue: todo.title)
        self._priority = State(initialValue: todo.priority)
        self._dueDateEnabled = State(initialValue: todo.dueDate != nil)
        self._dueDate = State(initialValue: todo.dueDate)
    }
    
    var body: some View {
        // NavigationStack 이 팝업일 경우에만 사용되어 뷰에서 분리함
        // 다른 NavigationStack 에서 페이지를 부를 경우 오류가 발생함 (중복 NavigationStack)
        Form {
            Section {
                TextField("Title", text: $title)
                Picker("우선순위", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) {
                        priority in
                        Text(priority.title)
                            .tag(priority)
                    }
                }
                Toggle("마감일 설정", isOn: $dueDateEnabled)
                if dueDateEnabled {
                    DatePicker("마감일",
                               selection: Binding(get: {
                        dueDate ?? Date()
                    }, set:{
                        dueDate = $0
                    }))
                }
            }
            Section("Category") {
                Picker("카테고리", selection: $selectedCategory) {
                    Text("선택안함").tag(Optional<Category>.none)
                    ForEach(categories) { category in
                        Text(category.name ?? "-").tag(Optional(category))
                    }
                }
            }

        }
        .navigationTitle("Edit Todo")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // 수정 기능
                    todo.title = title
                    todo.priority = priority
                    todo.dueDate = dueDateEnabled ? dueDate : nil
                    todo.category = selectedCategory
                    // 뷰 닫기와 동시에 모델 컨텍스트 저장이 호출된다.
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    // 수정 취소 기능
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditTodoView(todo: TodoItem(title: "Hello, world!"))
        .modelContainer(PreviewContainer.shared.container)
}
