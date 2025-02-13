import Foundation

let inputData: [[String: Any]] = [
    ["name": "Mercury", "positionFromSun": 1,
     "fractionOfEarthMass": 0.055,
     "distanceFromSunInAUs": 0.4, "hasRings": false],
    ["name": "Venus", "positionFromSun": 2,
     "fractionOfEarthMass": 0.815,
     "distanceFromSunInAUs": 0.7, "hasRings": false],
    ["name": "Earth", "positionFromSun": 3,
     "fractionOfEarthMass": 1.0,
     "distanceFromSunInAUs": 1.0, "hasRings": false],
    ["name": "Mars", "positionFromSun": 4,
     "fractionOfEarthMass": 0.107,
     "distanceFromSunInAUs": 1.5, "hasRings": false],
    ["name": "Jupiter", "positionFromSun": 5,
     "fractionOfEarthMass": 318.0,
     "distanceFromSunInAUs": 5.2, "hasRings": false],
    ["name": "Saturn", "positionFromSun": 6,
     "fractionOfEarthMass": 95.0,
     "distanceFromSunInAUs": 9.5, "hasRings": true],
    ["name": "Uranus", "positionFromSun": 7,
     "fractionOfEarthMass": 14.0,
     "distanceFromSunInAUs": 19.2, "hasRings": false],
    ["name": "Neptune", "positionFromSun": 8,
     "fractionOfEarthMass": 17.0,
     "distanceFromSunInAUs": 30.1, "hasRings": false]
]

struct Planet {
    let name: String
    let positionFromSun: Int
    let fractionOfEarthMass: Double
    let distanceFromSunInAUs: Double
    let hasRings: Bool
}

func makePlanet(fromInput input: [String: Any]) -> Planet? {
    guard let name = input["name"] as? String,
          let positionFromSun = input["positionFromSun"] as? Int,
          let fractionOfEarthMass = input["fractionOfEarthMass"] as? Double,
          let distanceFromSunInAUs = input["distanceFromSunInAUs"] as? Double,
          let hasRings = input["hasRings"] as? Bool else {
        return nil
    }
    
    return Planet(
        name: name,
        positionFromSun: positionFromSun,
        fractionOfEarthMass: fractionOfEarthMass,
        distanceFromSunInAUs: distanceFromSunInAUs,
        hasRings: hasRings)
}

func makePlanets(fromInput input: [[String: Any]]) -> [Planet] {
    var planets = [Planet]()
    for inputItem in input {
        guard let planet = makePlanet(fromInput: inputItem) else { continue }
        planets.append(planet)
    }
    return planets
}

let planets = makePlanets(fromInput: inputData)
print(planets)


// Defer
enum VideoGameReviewClass {
    case bad
    case average
    case good
    case brilliant
}

enum ClassificationState {
    case initial
    case classifying
    case complete
}

class VideoGameReviewClassifier {
    var state: ClassificationState = .initial

    func classify(forStarsOutOf10 stars: Int) -> VideoGameReviewClass {
        state = .classifying
        print("1")
        defer {
            print("3")
            state = .complete
        }

        // 오래 걸리는 작업
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("2")
        if stars > 8 {
            return .brilliant // 9 또는 10
        } else if stars > 6 {
            return .good // 7 또는 8
        } else if stars > 3 {
            return .average // 4, 5 또는 6
        } else {
            return .bad // 1, 2 또는 3
        }
    }
}

let classifier = VideoGameReviewClassifier()
let review1 = classifier.classify(forStarsOutOf10: 9)
print(review1) // brilliant


