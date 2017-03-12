//
//  TableViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 04.11.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class Pair: NSObject {
    
    var key = ""
    var value = ""
    
    init(key: String, value: String) {
        
        self.key = key
        self.value = value
    }
}

class State: NSObject {
    
    var name = ""
    
    var parameters = NSMutableOrderedSet()
}

class TableViewController: DropDownTableViewController {
    
    var data: [State] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let russia = State()
        russia.name = "Russia"
        russia.parameters.add(Pair(key: "Capital", value: "Moscow"))
        russia.parameters.add(Pair(key: "Square", value: "17 098 242"))
        
        let usa = State()
        usa.name = "USA"
        usa.parameters.add(Pair(key: "Capital", value: "Washington, D.C."))
        usa.parameters.add(Pair(key: "Square", value: "9 857 306"))
        usa.parameters.add(Pair(key: "Independence Day", value: "July 4"))
        
        let zimbabwe = State()
        zimbabwe.name = "Zimbabwe"
        zimbabwe.parameters.add(Pair(key: "Capital", value: "Harare"))
        
        self.data = [russia, usa, zimbabwe]
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func numberOfRows(in tableView: UITableView) -> Int {
        
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return self.data[row].parameters.count
    }
    
    override var showSubrowsInRow: Int? {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath)
        cell.textLabel?.text = self.data[row].name
        
        if row == self.nsk_selectedRow {
            
            cell.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            
        } else {
            
            cell.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
        }
        
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
    
    override func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let pair = self.data[row].parameters.object(at: subrow) as! Pair
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubrowCell", for: indexPath)
        cell.textLabel?.text = pair.key
        cell.detailTextLabel?.text = pair.value
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRow row: Int) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, canEditRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int) {
        
        if editingStyle == .delete {
            
            self.data.remove(at: row)
            
            tableView.deleteRows(at: [row], with: .automatic)
            
        } else if editingStyle == .insert {
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int) {
        
        if editingStyle == .delete {
            
            self.data[row].parameters.removeObject(at: subrow)
            
            tableView.deleteSubrows([subrow], in: row, with: .automatic)
            
        } else if editingStyle == .insert {
            
            let alertController = UIAlertController(title: "Insert new subrow", placeholders: ["parameter", "value"], completion: { (texts: [String?]) -> Void in
                
                let key = texts.first! ?? "??"
                let value = texts.last! ?? "??"
                
                self.data[row].parameters.insert(Pair(key: key, value: value), at: 0)
                
                tableView.insertSubrows([0], in: row, with: .automatic)
            })
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle {
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle {
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int) {
        
        //print(cell.textLabel?.text ?? "", row)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int) {
        
        //print(cell.detailTextLabel?.text ?? "", row, subrow)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, to proposedDestinationRow: Int) -> Int {
        
        return proposedDestinationRow
    }
    
    override func tableView(_ tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, to proposedDestinationSubrow: Int, inRow row: Int) -> Int {
        
        return proposedDestinationSubrow
    }
    
    override func tableView(_ tableView: UITableView, moveRow sourceRow: Int, to destinationRow: Int) {
        
        swap(&self.data[sourceRow], &self.data[destinationRow])
    }
    
    override func tableView(_ tableView: UITableView, moveSubrow sourceSubrow: Int, to destinationSubrow: Int, inRow row: Int) {
        
        let state = self.data[row]
        state.parameters.exchangeObject(at: sourceSubrow, withObjectAt: destinationSubrow)
    }
    
    override func tableView(_ tableView: UITableView, animationForInsertionIn row: Int) -> UITableViewRowAnimation {
        
        return .right
    }
    
    override func tableView(_ tableView: UITableView, animationForDeletionIn row: Int) -> UITableViewRowAnimation {
        
        return .left
    }
}
