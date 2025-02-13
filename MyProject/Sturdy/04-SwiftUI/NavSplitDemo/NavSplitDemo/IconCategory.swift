//
//  IconCategory.swift
//  NavSplitDemo
//
//  Created by Jungman Bae on 1/14/25.
//

import Foundation

struct IconCategory: Identifiable, Hashable {
    let id = UUID()
    var categoryName: String
    var images: [String]
}
