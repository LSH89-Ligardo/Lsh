import CoreLocation

class RecentList<T: CustomStringConvertible> {
    var slot1: T?
    var slot2: T?
    var slot3: T?
    var slot4: T?
    var slot5: T?
    
    func add(recent: T) {
        // 각 슬롯을 1칸씩 아래로
        slot5 = slot4
        slot4 = slot3
        slot3 = slot2
        slot2 = slot1
        slot1 = recent
    }
    
    func getAll() -> [T] {
        var recent = [T]()
        if let slot1 = slot1 { recent.append(slot1) }
        if let slot2 = slot2 { recent.append(slot2) }
        if let slot3 = slot3 { recent.append(slot3) }
        if let slot4 = slot4 { recent.append(slot4) }
        if let slot5 = slot5 { recent.append(slot5) }
        return recent
    }
}

let recentlyCopiedList = RecentList<Int>()
recentlyCopiedList.add(recent: 1)
recentlyCopiedList.add(recent: 2)
recentlyCopiedList.add(recent: 3)
var recentlyCopied = recentlyCopiedList.getAll()
print(recentlyCopied) // Last, Next, First


class Person: CustomStringConvertible {
    var description: String {
        return "Person(\(name))"
    }
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let rod = Person(name: "Rod")
let john = Person(name: "John")
let freddy = Person(name: "Freddy")

let recentlyVisitedList = RecentList<Person>()
recentlyVisitedList.add(recent: rod)
recentlyVisitedList.add(recent: john)
recentlyVisitedList.add(recent: freddy)
var recentlyVisited = recentlyVisitedList.getAll()

for person in recentlyVisited {
    print(person)
}

func makeDuplicates<T,Key: Hashable>(of item: T, withKeys keys: Set<Key>) -> [Key: T] {
    var duplicates: [Key: T] = [:]
    
    for key in keys {
        duplicates[key] = item
    }
    
    return duplicates
}

let awards: Set<String> = ["Best Visual Effects",
                           "Best Cinematography",
                           "Best Original Score",
                           "Best Film Editing"]

let oscars2022 = makeDuplicates(of: "Dune", withKeys: awards)

print(oscars2022["Best Visual Effects"] ?? "")

// 프로토콜과 제네릭

protocol TransportLocation {
    var location: CLLocation { get }
}

protocol TransportMethod {
    associatedtype CollectionPoint: TransportLocation
    
    var defaultCollectionPoint: CollectionPoint { get }
    var averageSpeedInKPH: Double { get }
}

enum TrainStation: String, TransportLocation {
    case BMS = "Bromley South"
    case VIC = "London Victoria"
    case RAI = "Rainhan (Kent)"
    case BTN = "Brighton (East Sussex)"
    
    var location: CLLocation {
        switch self {
        case .BMS:
            return CLLocation(latitude: 51.4000504, longitude: 0.0174237)
        case .VIC:
            return CLLocation(latitude: 51.4952103, longitude: -0.1438979)
        case .RAI:
            return CLLocation(latitude: 51.3663, longitude: 0.61137)
        case .BTN:
            return CLLocation(latitude: 50.829, longitude: -0.14125)
        }
    }
}

struct Train: TransportMethod {
    typealias CollectionPoint = TrainStation
    
    var defaultCollectionPoint: TrainStation {
        return TrainStation.BMS
    }
    var averageSpeedInKPH: Double { 100 }
}

class Journey<TransportType: TransportMethod> {
    let start: TransportType.CollectionPoint
    let end: TransportType.CollectionPoint
    let method: TransportType
    
    var distanceInKMs: Double
    var durationInHours: Double
    
    init(start: TransportType.CollectionPoint,
         end: TransportType.CollectionPoint,
         method: TransportType) {
        self.start = start
        self.end = end
        self.method = method
        
        // 미터 단위의 거리 값 / 1000 => 킬로미터 단위로 변환
        distanceInKMs = end.location.distance(from: start.location) / 1000
        durationInHours = distanceInKMs / method.averageSpeedInKPH
    }
}

let trainJourney = Journey(start: TrainStation.BMS,
                           end: TrainStation.VIC,
                           method: Train())

let distanceByTrain = trainJourney.distanceInKMs
let durationByTrain = trainJourney.durationInHours

print("여정 거리: \(distanceByTrain) km")
print("여정 소요 시간: \(durationByTrain) 시간")

extension CLLocation: TransportLocation {
    var location: CLLocation { self }
}

enum Road: TransportMethod {
    typealias CollectionPoint = CLLocation
    
    case car
    case motorbike
    case van
    case hgv
    
    var defaultCollectionPoint: CLLocation {
        return CLLocation(latitude: 51.1, longitude: 0.1)
    }
    
    var averageSpeedInKPH: Double {
        switch self {
        case .car: return 60
        case .motorbike: return 70
        case .van: return 55
        case .hgv: return 50
        }
    }
}

let start = CLLocation(latitude: 51.3994669, longitude: 0.0116888)
let end = CLLocation(latitude: 51.2968654, longitude: 0.5053609)
let roadJourney = Journey(start: start, end: end, method: Road.car)

let distanceByCar = roadJourney.distanceInKMs
let durationByCar = roadJourney.durationInHours

print("여정 거리: \(distanceByCar) km")
print("여정 소요 시간: \(durationByCar) 시간")
