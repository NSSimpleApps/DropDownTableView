//
//  DropDownTableViewDataSource.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 26.09.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
public protocol DropDownTableViewDataSource : NSObjectProtocol {
    
    /// object must return an array of regular indexpaths [IndexPath(forRow:inSection)]
    func tableView(_ tableView: UITableView, indexPathsForRows rows: [Int]) -> [IndexPath]
    
    /// object must return an array of regular indexpaths [IndexPath(forRow:inSection)]
    func tableView(_ tableView: UITableView, indexPathsForSubrows subrows: [Int], inRow row: Int) -> [IndexPath]
    
    /// some action for row and subrow
    func valueForIndexPath<T>(_ indexPath: IndexPath, valueForRow: (_ row: Int) -> T, valueForSubrow: (_ subrow: Int, _ row: Int) -> T) -> T
    
    /// implement this method and invoke while you delete rows manually
    func dropDownDeleteRows(_ rows: [Int], in tableView: UITableView)
    /// implement this method and invoke while you insert rows manually
    func dropDownInsertRows(_ rows: [Int], in tableView: UITableView)
    
    
    func numberOfRows(in tableView: UITableView) -> Int
    /*optional*/ func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int // default is 0
    
    func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell
    
    // default is .automatic
    /*optional*/ func tableView(_ tableView: UITableView, animationForInsertionIn row: Int) -> UITableViewRowAnimation
    /*optional*/ func tableView(_ tableView: UITableView, animationForDeletionIn row: Int) -> UITableViewRowAnimation
    
    /// define row whose subrow will be shown at initial appearance
    /*optional*/ var showSubrowsInRow: Int? { get } // default is nil
    
    // use tableView(_:titleFor{Header,Footer}InSection:) for section 0. other sections are ignored
    // /*optional*/ func titleForHeader(in tableView: UITableView) -> String?
    // /*optional*/ func titleForFooter(in tableView: UITableView) -> String?
    
    // default is false
    /*optional*/ func tableView(_ tableView: UITableView, canEditRow row: Int) -> Bool
    /*optional*/ func tableView(_ tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool
    
    /*optional*/ func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int)
    
    // default is false
    /*optional*/ func tableView(_ tableView: UITableView, canMoveRow row: Int) -> Bool
    /*optional*/ func tableView(_ tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool
    
    // default is nil
    ///*optional*/ func tableView(_ tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView?
    ///*optional*/ func tableView(_ tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView?
    
    /*optional*/ func tableView(_ tableView: UITableView, moveRow sourceRow: Int, to destinationRow: Int)
    /*optional*/ func tableView(_ tableView: UITableView, moveSubrow sourceSubrow: Int, to destinationSubrow: Int, inRow row: Int)
}

extension DropDownTableViewController: DropDownTableViewDataSource {
    
    open func tableView(_ tableView: UITableView, animationForInsertionIn row: Int) -> UITableViewRowAnimation {
        
        return .automatic
    }
    
    open func tableView(_ tableView: UITableView, animationForDeletionIn row: Int) -> UITableViewRowAnimation {
        
        return .automatic
    }
    
    open func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return 0
    }
    
    /*optional*/ open func tableView(_ tableView: UITableView, canEditRow row: Int) -> Bool {
        
        return false
    }
    /*optional*/ open func tableView(_ tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    /*optional*/ open func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int) {}
    /*optional*/ open func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int) {}
    
    /*optional*/ open func tableView(_ tableView: UITableView, canMoveRow row: Int) -> Bool {
        
        return false
    }
    /*optional*/ open func tableView(_ tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
//    /*optional*/ open func tableView(_ tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
//        
//        return nil
//    }
//    /*optional*/ open func tableView(_ tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
//        
//        return nil
//    }
    
    /*optional*/ open func tableView(_ tableView: UITableView, moveRow sourceRow: Int, to destinationRow: Int) {}
    /*optional*/ open func tableView(_ tableView: UITableView, moveSubrow sourceSubrow: Int, to destinationSubrow: Int, inRow row: Int) {}
}
