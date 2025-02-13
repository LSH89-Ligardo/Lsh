import Foundation

enum GridPosition: String {
    case empty = " "
    case player1 = "o"
    case player2 = "x"
}

struct TicTacToe {
    var gridStorage: [[GridPosition]] = []
    
    init () {
        for _ in 0..<3 {
            gridStorage.append(Array(repeating: .empty, count: 3)) // [.empty, .empty, .empty]
        }
        // print(self.gridStorage)
        // [ [.empty, .empty, .empty],
        //   [.empty, .empty, .empty],
        //   [.empty, .empty, .empty] ]
    }
    
    subscript(row: Int, column: Int) -> GridPosition {
        get {
            return gridStorage[row][column] }
        set (newValue) {
            gridStorage[row][column] = newValue
        }
    }
        
    func gameStateString() -> String {
        var stateString = "----------\n"
        for row in gridStorage {
            stateString += printableString(forRow: row)
        }
        stateString += "----------\n"
        return stateString
    }
    
    func printableString(forRow row: [GridPosition]) -> String {
        var rowString = "|"
        for position in row {
            rowString += position.rawValue + "|"
        }
        return rowString + "\n"
    }
}

var game = TicTacToe()
game[1, 1] = .player1
print(game.gameStateString())

game[0, 2] = .player2
print(game.gameStateString())

game[0, 0] = .player1
print(game.gameStateString())

game[1, 2] = .player2
print(game.gameStateString())

game[2, 2] = .player1
print(game.gameStateString())

let topLeft = game[0, 0]
let middle = game[1, 1]
let bottomRight = game[2, 2]
let p1hasWon = (topLeft == .player1) && (middle == .player1) && (bottomRight == .player1)
print(p1hasWon)
