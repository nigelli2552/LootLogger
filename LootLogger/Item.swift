//
//  Item.swift
//  LootLogger
//
//  Created by nigelli on 2023/4/24.
//

import Foundation
import UIKit

class Item: Equatable, Codable {
    var name: String
    var serialNumber: String?
    var valueInDollars: Int
    let dateCreated: Date
    let itemKey: String

    init(name: String, valueInDollars: Int, serialNumber: String? = nil) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        dateCreated = Date()
        itemKey = UUID().uuidString
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
}
