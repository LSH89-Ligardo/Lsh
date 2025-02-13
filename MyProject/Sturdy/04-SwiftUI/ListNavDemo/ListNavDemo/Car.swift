//
//  Car.swift
//  ListNavDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import Foundation

struct Car: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var imageName: String
    var isHybrid: Bool
}
