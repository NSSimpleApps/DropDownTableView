//
//  TestViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 26.12.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

private extension Date {
    
    var customDateFormat: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        
        return dateFormatter.string(from: self)
    }
}

class TestViewController: DropDownTableViewController {
    
    fileprivate var value = 0
    fileprivate var date = Date()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "Test"
        
        let userDefaults = UserDefaults.standard
        
        self.value = userDefaults.integer(forKey: "value")
        
        if let date = userDefaults.object(forKey: "date") as? Date {
            
            self.date = date
        }
    }

    deinit {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.value, forKey: "value")
        userDefaults.set(self.date, forKey: "date")
    }
    
    override func numberOfRows(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if row == 0 {
            
            cell.textLabel?.text = "Value"
            cell.detailTextLabel?.text = String(self.value)
            
        } else {
            
            cell.textLabel?.text = "Date"
            cell.detailTextLabel?.text = self.date.customDateFormat
        }
        
        if row == self.nsk_selectedRow {
            
            cell.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            
        } else {
            
            cell.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath)
            
            // this is dirty hack. Don't do it anymore
            if let pickerView = cell.contentView.subviews.first as? UIPickerView {
                
                pickerView.selectRow(self.value, inComponent: 0, animated: false)
            }
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
            
            // this is dirty hack. Don't do it anymore
            if let datePicker = cell.contentView.subviews.first as? UIDatePicker {
                
                datePicker.date = self.date
            }
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
    
    override func tableView(_ tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return 216
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        self.date = sender.date
        
        if let cell = self.tableView.cellForRow(at: 1) {
            
            cell.detailTextLabel?.text = self.date.customDateFormat
        }
    }
}

extension TestViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 10
    }
}

extension TestViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.value = row
        
        if let cell = self.tableView.cellForRow(at: 0) {
            
            cell.detailTextLabel?.text = String(self.value)
        }
    }
}


