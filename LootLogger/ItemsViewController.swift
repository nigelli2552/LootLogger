//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by nigelli on 2023/4/22.
//

import Foundation
import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemStore.allItems.count
    }
}
