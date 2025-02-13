// 파일 전송 과정에서 발생할 수 있는 에러 타입을 정의한 열거형
enum FileTransferError: Error {
    case noConnection    // 네트워크 연결이 없는 경우
    case lowBandwidth   // 네트워크 속도가 너무 낮은 경우
    case fileNotFound   // 전송할 파일을 찾을 수 없는 경우
}

// 실제 파일 전송을 처리하는 함수
func fileTransfer() throws {
    // 연결 상태, 속도, 파일 존재 여부를 확인하는 테스트용 변수들
    let connectionOK = true        // 네트워크 연결 상태 (true: 연결됨)
    let connectionSpeed: Int = 20  // 현재 네트워크 속도 (Mbps)
    let fileFound: Bool = true    // 파일 존재 여부 (true: 존재함)
    
    // guard 문을 사용하여 각 조건을 확인하고, 조건이 맞지 않으면 에러를 발생시킴
    guard connectionOK else {
        throw FileTransferError.noConnection
    }
    guard connectionSpeed > 30 else {  // 최소 요구 속도: 30Mbps
        throw FileTransferError.lowBandwidth
    }
    guard fileFound else {
        throw FileTransferError.fileNotFound
    }
    // 모든 조건이 충족되면 실제 파일 전송 로직이 실행될 위치
}

// 임시 파일들을 제거하는 함수
func removeTmpFiles() {}
// 네트워크 연결을 종료하는 함수
func closeConnection() {}

// 파일 전송의 전체 프로세스를 관리하는 메인 함수
func sendFile() -> String {
    // defer 블록: 함수가 종료되기 전에 반드시 실행되어야 하는 정리 작업
    defer {
        removeTmpFiles()    // 임시 파일 정리
        closeConnection()   // 연결 종료
    }
    
    // do-catch 문을 사용하여 발생 가능한 에러들을 처리
    do {
        try fileTransfer()          // 파일 전송 시도
        return "Successful transfer" // 성공 시 메시지 반환
    } catch FileTransferError.noConnection {
        return "No Network Connection"        // 네트워크 연결 없음 에러 처리
    } catch FileTransferError.lowBandwidth {
        return "File Transfer Speed too Low"  // 낮은 대역폭 에러 처리
    } catch FileTransferError.fileNotFound {
        return "File not Found"              // 파일 없음 에러 처리
    } catch {
        return "Unknown error"               // 기타 예상치 못한 에러 처리
    }
}
