import Foundation

class ClassSample {
    private var intValue: Int = 0
    
    func increment() {
        intValue += 1
        print(self.intValue)
    }
}

actor ActorSample {
    private var intValue: Int = 0
    
    func increment() async {
        intValue += 1
        print(intValue)
    }
}

let classInstance = ClassSample()
let actorInstance = ActorSample()

print("---Class---")

DispatchQueue.concurrentPerform(iterations: 20) { _ in
    classInstance.increment()
}

print("---Actor---")

DispatchQueue.concurrentPerform(iterations: 20) { _ in
    Task {
        await actorInstance.increment()
    }
}


