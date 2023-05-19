//
//  Item.swift
//  LootLogger
//
//  Created by nigelli on 2023/4/24.
//

import Foundation
import UIKit

enum Category {
    case electronics
    case clothing
    case book
    case other
}

enum CodingKeys: String, CodingKey {
    case name
    case serialNumber
    case valueInDollars
    case dateCreated
    case category
}

class Item: Equatable, Codable {
    var category = Category.other
    var name: String
    var serialNumber: String?
    var valueInDollars: Int
    let dateCreated: Date
    init(name: String, valueInDollars: Int, serialNumber: String? = nil) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        dateCreated = Date()
    }

    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]

            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!

            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0 ..< 100)
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!

            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }

    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
            && lhs.serialNumber == rhs.serialNumber
            && lhs.dateCreated == rhs.dateCreated
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(valueInDollars, forKey: .valueInDollars)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encode(dateCreated, forKey: .dateCreated)
        switch category {
        case .electronics:
            try container.encode("electronics", forKey: .category)
        case .clothing:
            try container.encode("clothing", forKey: .category)
        case .book:
            try container.encode("book", forKey: .category)
        case .other:
            try container.encode("other", forKey: .category)
        }
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        valueInDollars = try container.decode(Int.self, forKey: .valueInDollars)
        serialNumber = try container.decode(String?.self, forKey: .serialNumber)
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)

        let categoryString = try container.decode(String.self, forKey: .category)
        switch categoryString {
        case "electronics":
            category = .electronics
        case "clothing":
             category = .clothing
        case "book":
            category = .book
        case "other":
            category = .other
        default:
            category = .other
        }
    }
}
