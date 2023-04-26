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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell with default appearance
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell=tableView.dequeueReusableCell(withIdentifier: "UITabelViewCell", for: indexPath)

        // Set the text on the cell with the description of the item, that is at nth index of items, where n = row this cell, will appear in on the table view
        let item = itemStore.allItems[indexPath.row]

        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"

        return cell
    }
}
