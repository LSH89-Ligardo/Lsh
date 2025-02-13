import Foundation

func howLongUntilHalloween() -> String {
    let calendar = Calendar.current
    let timeZone = TimeZone.current
    
    let now = Date()
    
    let yearOfNextHalloween = calendar.component(.year, from: now) // 2025
    
    var components = DateComponents(calendar: calendar, timeZone: timeZone, year: yearOfNextHalloween, month: 10, day: 31, hour: 0, minute: 0, second: 0)
    
    guard var halloween = components.date else {
        print("할로윈 날짜를 가져올 수 없습니다.")
        return ""
    }
    
    if halloween < now {                          // 올해 할로윈이 지났다면,
        components.year = yearOfNextHalloween + 1 // 다음 해 할로윈으로 변경
        halloween = components.date!
    }
    
    let componentFormatter = DateComponentsFormatter()
    componentFormatter.unitsStyle = .full
    componentFormatter.allowedUnits = [.month, .day, .hour, .minute, .second]
    
    return componentFormatter.string(from: now, to: halloween)!
}

let timeUntilHalloween = howLongUntilHalloween()
print("할로윈까지 \(timeUntilHalloween) 남았습니다.")
