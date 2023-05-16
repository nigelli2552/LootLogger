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

    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }

    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }

        // Get reference to object being moved so you can reinsert it
        let moveItem = allItems[fromIndex]

        // Remove item from array
        allItems.remove(at: fromIndex)

        // Insert item in array at new location
        allItems.insert(moveItem, at: toIndex)
    }

    func saveChanges() -> Bool {
        do {
            let encoder = PropertyListEncoder()
            let _ = try encoder.encode(allItems)
        } catch let encodingError {
            print("Error encoding allItems: \(encodingError)")
        }
        return false
    }
}
