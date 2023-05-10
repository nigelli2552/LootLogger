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

    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)

            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)

            // Enter editing mode
            setEditing(true, animated: true)
        }
    }

    @IBAction func addNewItem(_ sender: UIButton) {
        // Figure out where that item is in the array
        let newItem = itemStore.createItem()
        if let idx = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: idx, section: 0)

            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        // Set the text on the cell with the description of the item, that is at nth index of items, where n = row this cell, will appear in on the table view
        let item = itemStore.allItems[indexPath.row]

        // Configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]

            // Remove the item from the store
            itemStore.removeItem(item)

            // Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
