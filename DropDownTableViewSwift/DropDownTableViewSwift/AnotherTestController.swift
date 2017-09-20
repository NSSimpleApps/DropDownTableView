//
//  TestViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 26.12.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class AnotherTestController: DropDownTableViewController {
    
    fileprivate var numberOfSubrows = 3
    fileprivate var numberOfRows = 10
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Another test"
        
        self.navigationItem.rightBarButtonItems =
        [UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(self.insertRows(_:))),
        UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(self.deleteRows(_:)))]
    }
    
    func insertRows(_ sender: UIBarButtonItem) {
        
        self.numberOfRows += 2
        
        self.tableView.insertRows(at: [0, 1], with: .automatic)
    }
    
    func deleteRows(_ sender: UIBarButtonItem) {
        
        self.numberOfRows -= 2
        
        self.tableView.deleteRows(at: [0, 1], with: .automatic)
    }
    
    override func numberOfRows(in tableView: UITableView) -> Int {
        
        return self.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return self.numberOfSubrows
    }
    
    override func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Row " + String(row)
        cell.detailTextLabel?.text = nil
        
        if row == self.nsk_selectedRow {
            
            cell.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            
        } else {
            
            cell.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Subrow " + String(row)
        cell.detailTextLabel?.text = String(subrow)
        cell.accessoryView = nil
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRow row: Int) {
        
        switch (self.nsk_selectedRow, row) {
            
        case (let sr?, _) where row == sr:
            tableView.cellForRow(at: row)?.accessoryView =  UIImageView(image: UIImage(named: "down_arrow"))
            tableView.deselect(row: row, animated: true)
            break
            
        case (let sr?, _) where row != sr:
            tableView.cellForRow(at: row)?.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            tableView.cellForRow(at: sr)?.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
            break
            
        case (nil, _):
            tableView.cellForRow(at: row)?.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            break
            
        default:
            break
        }
        
        super.tableView(tableView, didSelectRow: row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectSubrow subrow: Int, inRow row: Int) {
        
        print(#function, subrow, row)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRow row: Int) {
        
        print(#function, row)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectSubrow subrow: Int, inRow row: Int) {
        
        print(#function, subrow, row)
    }
}

