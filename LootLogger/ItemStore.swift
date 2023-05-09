//
//  ItemStore.swift
//  LootLogger
//
//  Created by nigelli on 2023/4/25.
//

import Foundation
import UIKit

class ItemStore {
    var allItems = [Item]()
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }

//    init() {
//        for _ in 0 ..< 5 {
//            createItem()
//        }
//    }

    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
}
