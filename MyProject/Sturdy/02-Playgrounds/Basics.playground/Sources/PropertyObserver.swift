//
//  PropertyObserver.swift
//  
//
//  Created by Jungman Bae on 1/2/25.
//

class Manager {
    var currentUserName: String = "" {
        willSet(newName) { // newValue (기본 매개변수)는 생략 가능, 기본 매개변수의 이름 변경 가능
            print("기존 '\(currentUserName)'이 '\(newName)'으로 변경됩니다.")
        }
        didSet { // oldValue 파라미터는 생략 가능 = 기본 매개변수
            print("기존 '\(oldValue)'이 '\(currentUserName)'으로 변경되었습니다.")
        }
    }
    
    init(_ currentUserName: String) {
        self.currentUserName = currentUserName
    }
    
    func changeManage(_ name: String) {
        self.currentUserName = name
    }
}

public func runPropertyObserver() {
    let manager = Manager("배정만")
    manager.changeManage("이재용")
}
