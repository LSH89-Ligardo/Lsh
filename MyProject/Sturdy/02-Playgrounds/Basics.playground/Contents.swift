import Foundation

//runOptional()
//runFunction()
//runClass()
//runStruct()
//runEnum()
//runClosure()
//runProtocol()
//runTypealias()
//runIfElse()


enum CompassPoint {
    case north
    case south
    case east
    case west
}

func lookTowards(_ direction: CompassPoint) {
    switch direction {
    case .north:
        print("북쪽으로는 구불구불한 길이 있습니다")
    case .south:
        print("남쪽에는 프랜싱 포니 선술집이 있습니다")
    case .east:
        print("동쪽에는 대장간이 있습니다")
    case .west:
        print("서쪽에는 마을 광장이 있습니다")
    }
}

lookTowards(.south)

enum Item {
    case key
    case lockedDoor
    case openDoor
    case bluntKnife
    case sharpeningStone
    case sharpKnife
}

func combine(_ firstItem: Item, with secondItem: Item) -> Item? {
    switch (firstItem, secondItem) {
    case (.key, .lockedDoor):
        print("문을 열었습니다!")
        return .openDoor
    case (.bluntKnife, .sharpeningStone):
        print("칼이 날카로워졌습니다.")
        return .sharpKnife
    default:
        print("\(firstItem)과 \(secondItem)은 결합할 수 없습니다.")
        return nil
    }
}

let door = combine(.key, with: .lockedDoor)
let oilAndWater = combine(.bluntKnife, with: .lockedDoor)

// For Loop

let ledZeppelin = ["Robert", "Jimmy", "John", "John Paul"]

for (index, value) in ledZeppelin.enumerated() {
    print("\(index): \(value)")
}

for value in 1...12 {
    print("5 x \(value) = \(value * 5)")
}

let zeppelinByInstrument = ["vocals": "Robert",
                            "lead guitar": "Jimmy",
                            "drums": "John",
                            "bass guitar": "John Paul"]

for (key, value) in zeppelinByInstrument {
    print("\(value)가 \(key)를 연주합니다.")
}

//ledZeppelin.forEach { musician in print(musician) }
ledZeppelin.forEach { print($0) }

zeppelinByInstrument.forEach { (key, value) in print("\(value)가 \(key)를 연주합니다.") }

// While Loop

enum CoinFlip: Int {
    case heads = 0
    case tails = 1
    
    static func flipCoin() -> CoinFlip {
        return CoinFlip(rawValue: Int.random(in: 0...1))!
    }
}

func howManyHeadsInARow() -> Int {
    var numberOfHeadsInARow = 0
    var currentFlip: CoinFlip = CoinFlip.flipCoin()
    print("currentFlip.rawValue: \(currentFlip.rawValue)")
    while currentFlip == .heads {
        numberOfHeadsInARow += 1
        currentFlip = CoinFlip.flipCoin()
    }
    
    return numberOfHeadsInARow
}

let noOfHeads = howManyHeadsInARow()
print(noOfHeads)


enum MealState {
    case initial
    case buyIngredients
    case prepareIngredients
    case cook
    case plateUp
    case serve
}

enum MealError: Error {
    case canOnlyMoveToAppropriateState(from: MealState, to: MealState)
    case tooMuchSalt
    case wrongStateToAddSalt
}

class Meal {
    private(set) var state: MealState = .initial
    private(set) var saltAdded = 0

    func change(to newState: MealState) throws {
        switch (state, newState) {
        case (.initial, .buyIngredients),
            (.buyIngredients, .prepareIngredients),
            (.prepareIngredients, .cook),
            (.cook, .plateUp),
            (.plateUp, .serve):
            state = newState
        default:
            throw MealError.canOnlyMoveToAppropriateState(from: state, to: newState)
        }
    }
    
    func addSalt() throws {
        print("addSalt >> \(saltAdded) / \(state)")
        if saltAdded >= 5 {
            throw MealError.tooMuchSalt
        } else if .initial == state || .buyIngredients == state {
            throw MealError.wrongStateToAddSalt
        } else {
            saltAdded += 1
        }
    }
    
    func buyIngredients() throws {
        try change(to: .buyIngredients)
    }
    func prepareIngredients() throws {
        try change(to: .prepareIngredients)
    }
    func cook() throws {
        try change(to: .cook)
    }
    func plateUp() throws {
        try change(to: .plateUp)
    }
    func serve() throws {
        try change(to: .serve)
    }
}

let dinner = Meal()

do {
//    try dinner.change(to: .buyIngredients)
//    try dinner.change(to: .prepareIngredients)
//    try dinner.change(to: .cook)
//    try dinner.change(to: .plateUp)
//    try dinner.change(to: .serve)
    
    try dinner.addSalt()
    try dinner.prepareIngredients()
    try dinner.buyIngredients()
    try dinner.cook()
    try dinner.plateUp()
    try dinner.serve()
    
    print("저녁 식사가 준비되었습니다!")
} catch MealError.canOnlyMoveToAppropriateState(let from, let to) {
    print("\(from) -> \(to) 상태로 이동할 수 없습니다.")
} catch MealError.tooMuchSalt {
    print("짜다!")
} catch MealError.wrongStateToAddSalt {
    print("이 단계에서는 소금을 추가할 수 없습니다.")
}

