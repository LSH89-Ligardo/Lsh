// 게임 보드를 표현하는 열거형
enum Piece: String {
    case empty = " "
    case x = "X"
    case o = "O"
}

typealias Line = [Piece]
typealias Board = [Line]
//typealias Board = [[Piece]]

// 게임 상태를 표현하는 프로토콜
protocol GameState {
    var currentPlayer: Piece { get }
    // [[Piece]] 는 타입별칭을 만들 수 있다.
    var board: Board { get }
    func isValidMove(row: Int, column: Int) -> Bool
}

// 게임 로직을 담당하는 클래스
class TicTacToe: GameState {
    var board: Board
    var currentPlayer: Piece
    
    init() {
        board = [[.empty, .empty, .empty],
                 [.empty, .empty, .empty],
                 [.empty, .empty, .empty]]
        currentPlayer = .x // x가 첫 번째 플레이어
    }
    
    func isValidMove(row: Int, column: Int) -> Bool {
        // 이동 범위 확인 (0-2 사이인지)
        guard row >= 0 && row < 3, column >= 0 && column < 3 else {
            return false
        }
        // 빈칸인지 확인
        return board[row][column] == .empty
    }
    
    func makeMove(row: Int, column: Int) -> Bool {
        // 위치 선정이 적합한지 판정
        guard isValidMove(row: row, column: column) else {
            return false
        }
        // 해당 위치에 현재 플레이어의 피스를 할당
        board[row][column] = currentPlayer
        // 위치 선정이 끝나면(함수 실행의 마지막), 플레이어 전환
        defer {
            currentPlayer = currentPlayer == .x ? .o : .x
        }
        // 정상적으로 할당이 끝나면 true
        return true
    }
    
    func checkWinner() -> Piece? {
        var lines = [Line]()
        // 가로
        lines.append([board[0][0],board[0][1],board[0][2]])
        lines.append([board[1][0],board[1][1],board[1][2]])
        lines.append([board[2][0],board[2][1],board[2][2]])
        // 세로
        lines.append([board[0][0],board[1][0],board[2][0]])
        lines.append([board[0][1],board[1][1],board[2][1]])
        lines.append([board[0][2],board[1][2],board[2][2]])
        // 대각선
        lines.append([board[0][0],board[1][1],board[2][2]])
        lines.append([board[2][0],board[1][1],board[0][2]])
        
        for line in lines {
            if line.allSatisfy({$0 == .x}) {
                return .x
            }
            if line.allSatisfy({$0 == .o}) {
                return .o
            }
        }
        for line in lines {
            if line.contains(.empty) && (Set<Piece>(line).count < 3) {
                return nil
            }
        }
        return .empty
    }
    
    func printBoard() {
        // 보드를 출력하는 코드
        print("\n현재 플레이어: \(currentPlayer)")
        print("---------------------")
        for row in board {
            print("| \(row[0].rawValue) \(row[1].rawValue) \(row[2].rawValue) |")
        }
        print("---------------------")
    }
}

var game = TicTacToe()

while true {
    game.printBoard()
    print("\n현재 플레이어: \(game.currentPlayer)")
    
    print("행 입력 (0-2)('q' 입력시 종료): ", terminator: "")
    let rowInput = readLine() ?? ""
    if rowInput == "q" { break }
    guard let row = Int(rowInput) else { continue }
    
    print("열 입력 (0-2)('q' 입력시 종료): ", terminator: "")
    let colInput = readLine() ?? ""
    if colInput == "q" { break }
    guard let column = Int(colInput) else { continue }
    
    if !game.makeMove(row: row, column: column) {
        print("잘못된 위치입니다. 다시 시도해주세요.")
        continue
    }
    
    if let winner = game.checkWinner() {
        game.printBoard()
        if winner == .empty {
            print("무승부")
        } else {
            print("\(winner) 승리")
        }
        break
    }
}
