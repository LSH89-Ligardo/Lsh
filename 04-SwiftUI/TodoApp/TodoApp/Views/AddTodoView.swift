//
//  AddTodoView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
    // 데이터 저장소에 접근할 수 있는 환경 변수
    @Environment(\.modelContext) private var modelContext
    // 나를 호출한 뷰에서 닫기 기능을 동작 시키는 환경 변수(클로저)
    @Environment(\.dismiss) private var dismiss
    
    @Query private var categories: [Category]
    
    @State private var title: String = ""
    @State private var priority: Priority = .medium
    @State private var dueDateEnabled = false
    @State private var dueDate: Date? = nil
    @State private var selectedCategory: Category?
    
    @State private var isAddingCategory = false
    @State private var newCategoryName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("제목", text: $title)
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
                    Button("카테고리 추가") {
                        isAddingCategory = true
                    }
                }
            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let todo = TodoItem(title: title,
                                            priority: priority,
                                            dueDate: dueDateEnabled ? dueDate : nil,
                                            category: selectedCategory
                        )
                        modelContext.insert(todo)
                        // 뷰 닫기와 동시에 모델 컨텍스트 저장이 호출된다.
                        dismiss()
                    }
                }
            }
            .alert("카테고리 추가",
                isPresented: $isAddingCategory
            ) {
                TextField("카테고리 이름", text: $newCategoryName)
                HStack {
                    Button("취소") {
                        newCategoryName = ""
                    }
                    Button("추가") {
                        if !newCategoryName.isEmpty {
                            let category = Category(name: newCategoryName)
                            modelContext.insert(category)
                        }
                    }
                }
            } message: {
                Text("카테고리 이름을 입력하세요.")
            }
        }
    }
}

#Preview {
    AddTodoView()
        .modelContainer(PreviewContainer.shared.container)
}
