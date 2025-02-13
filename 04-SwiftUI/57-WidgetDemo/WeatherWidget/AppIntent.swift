//
//  AppIntent.swift
//  WeatherWidget
//
//  Created by Jungman Bae on 1/22/25.
//

import WidgetKit
import AppIntents


struct CharacterDetail: AppEntity {
    let id: String
    let avatar: String
    let healthLevel: Double
    let heroType: String
    let isAvailable = true
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Character"
    static var defaultQuery = CharacterQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(avatar) \(id)")
    }


    static let allCharacters: [CharacterDetail] = [
        CharacterDetail(id: "Power Panda", avatar: "🐼", healthLevel: 0.14, heroType: "Forest Dweller"),
        CharacterDetail(id: "Unipony", avatar: "🦄", healthLevel: 0.67, heroType: "Free Rangers"),
        CharacterDetail(id: "Spouty", avatar: "🐳", healthLevel: 0.83, heroType: "Deep Sea Goer")
    ]
}

struct CharacterQuery: EntityQuery {
    func entities(for identifiers: [CharacterDetail.ID]) async throws -> [CharacterDetail] {
        CharacterDetail.allCharacters.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [CharacterDetail] {
        CharacterDetail.allCharacters.filter { $0.isAvailable }
    }
    
    func defaultResult() async -> CharacterDetail? {
        try? await suggestedEntities().first
    }
}


struct SelectCharacterIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Character"
    static var description = IntentDescription("Selects the character to display information for.")


    @Parameter(title: "Character")
    var character: CharacterDetail?


    init(character: CharacterDetail) {
        self.character = character
    }


    init() {
    }
}



//struct WeatherLocation: AppEntity {
//    let id: String
//    var city: String
//    let isAvailable = true
//        
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Weather Location"
//    static var defaultQuery = WeatherLocationQuery()
//    
//    var displayRepresentation: DisplayRepresentation {
//        DisplayRepresentation(title: "\(id)")
//    }
//
//    static let london = WeatherLocation(id: "London", city: "London")
//    static let miami = WeatherLocation(id: "Miami", city: "Miami")
//    
//    
//    static let allLocations: [WeatherLocation] = [
//        WeatherLocation(id: "London", city: "London"),
//        WeatherLocation(id: "Miami", city: "Miami"),
//        WeatherLocation(id: "Seoul", city: "Seoul"),
//        WeatherLocation(id: "Busan", city: "Busan"),
//    ]
//}
//
//struct WeatherLocationQuery: EntityQuery {
//    func entities(for identifiers: [WeatherLocation.ID]) async throws -> [WeatherLocation] {
//        return WeatherLocation.allLocations.filter( { identifiers.contains($0.id) })
//    }
//    
//    func suggestedEntities() async throws -> some ResultsCollection {
//        return WeatherLocation.allLocations.filter({ $0.isAvailable })
//    }
//    
//    func defaultResult() async -> WeatherLocation? {
//        try? await suggestedEntities().first
//    }
//}
//
//struct ConfigurationAppIntent: WidgetConfigurationIntent {
//    static var title: LocalizedStringResource { "Configuration" }
//    static var description: IntentDescription { "This is an example widget." }
//    
//    @Parameter(title: "지역 설정")
//    var location: WeatherLocation?
//    
//    
//    init(location: WeatherLocation) {
//        self.location = location
//    }
//    
//    init() {}
//}
