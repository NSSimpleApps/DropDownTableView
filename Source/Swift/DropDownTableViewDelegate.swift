//
//  DropDownTableViewDelegate.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 25.09.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
public protocol DropDownTableViewDelegate : NSObjectProtocol {
    
    /*optional*/ func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView)
    /*optional*/ func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView)
    
    /*optional*/ func tableView(_ tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView)
    /*optional*/ func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView)
    
    /*optional*/ func tableView(_ tableView: UITableView, heightForRow row: Int) -> CGFloat
    /*optional*/ func tableView(_ tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat
    
    // use tableView(_:heightFor{Header,Footer}InSection:) for section 0. other sections are ignored
    // /*optional*/ func heightForHeader(in tableView: UITableView) -> CGFloat
    // /*optional*/ func heightForFooter(in tableView: UITableView) -> CGFloat
    
    /*optional*/ func tableView(_ tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat
    /*optional*/ func tableView(_ tableView: UITableView, estimatedHeightForSubrow subrow: Int, inRow row: Int) -> CGFloat
    
    // use tableView(_:estimatedHeightFor{Header,Footer}InSection:) for section 0. other sections are ignored
    // /*optional*/ func estimatedHeightForHeader(in tableView: UITableView) -> CGFloat
    // /*optional*/ func estimatedHeightForFooter(in tableView: UITableView) -> CGFloat
    
    // use tableView(_:viewFor{Header,Footer}InSection:) for section 0. other sections are ignored
    // /*optional*/ func viewForHeader(in tableView: UITableView) -> UIView?
    // /*optional*/ func viewForFooter(in tableView: UITableView) -> UIView?
    
    /*optional*/ func tableView(_ tableView: UITableView, accessoryButtonTappedForRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, inRow row: Int)
    
    // default is true
    /*optional*/ func tableView(_ tableView: UITableView, shouldHighlightRow row: Int) -> Bool
    /*optional*/ func tableView(_ tableView: UITableView, shouldHighlightSubrow subrow: Int, inRow row: Int) -> Bool
    
    /*optional*/ func tableView(_ tableView: UITableView, didHighlightRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, didHighlightSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(_ tableView: UITableView, didUnhighlightRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, didUnhighlightSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(_ tableView: UITableView, didSelectRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, didSelectSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(_ tableView: UITableView, didDeselectRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, didDeselectSubrow subrow: Int, inRow row: Int)
    
    // default is .none
    /*optional*/ func tableView(_ tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle
    /*optional*/ func tableView(_ tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle
    
    /*optional*/ func tableView(_ tableView: UITableView, editActionsForRow row: Int) -> [UITableViewRowAction]?
    /*optional*/ func tableView(_ tableView: UITableView, editActionsForSubrow subrow: Int, inRow row: Int) -> [UITableViewRowAction]?
    
    /*optional*/ func tableView(_ tableView: UITableView, indentationLevelForRow row: Int) -> Int
    /*optional*/ func tableView(_ tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int
    
    // default is false
    /*optional*/ func tableView(_ tableView: UITableView, shouldShowMenuForRow row: Int) -> Bool
    /*optional*/ func tableView(_ tableView: UITableView, shouldShowMenuForSubrow subrow: Int, inRow row: Int) -> Bool
    
    // default is true
    /*optional*/ func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt row: Int, withSender sender: Any?) -> Bool
    /*optional*/ func tableView(_ tableView: UITableView, canPerformAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: Any?) -> Bool
    
    /*optional*/ func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt row: Int, withSender sender: Any?)
    /*optional*/ func tableView(_ tableView: UITableView, performAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: Any?)
    
    // default is false
    /*optional*/ func tableView(_ tableView: UITableView, shouldIndentWhileEditingRow row: Int) -> Bool
    /*optional*/ func tableView(_ tableView: UITableView, shouldIndentWhileEditingSubrow subrow: Int, inRow row: Int) -> Bool
    
    /*optional*/ func tableView(_ tableView: UITableView, willBeginEditingRow row: Int)
    /*optional*/ func tableView(_ tableView: UITableView, willBeginEditingSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(_ tableView: UITableView, didEndEditingRow row: Int?)
    /*optional*/ func tableView(_ tableView: UITableView, didEndEditingSubrow subrow: Int?, inRow row: Int?)
    
    /*optional*/ func tableView(_ tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, to proposedDestinationRow: Int) -> Int // default is sourceRow
    /*optional*/ func tableView(_ tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, to proposedDestinationSubrow: Int, inRow row: Int) -> Int // default is sourceSubrow
}

extension DropDownTableViewController: DropDownTableViewDelegate {
    
    open func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int) {}
    open func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView) {}
    open func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView) {}
    
    open func tableView(_ tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int) {}
    open func tableView(_ tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView) {}
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView) {}
    
    open func tableView(_ tableView: UITableView, heightForRow row: Int) -> CGFloat {
                
        return 44//tableView.rowHeight
    }
    open func tableView(_ tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return 44//tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat {
        
        return 44//tableView.estimatedRowHeight
    }
    open func tableView(_ tableView: UITableView, estimatedHeightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return 44//tableView.estimatedRowHeight
    }
    
    open func tableView(_ tableView: UITableView, accessoryButtonTappedForRow row: Int) {}
    open func tableView(_ tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, shouldHighlightRow row: Int) -> Bool {
        
        return true
    }
    open func tableView(_ tableView: UITableView, shouldHighlightSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return true
    }
    
    open func tableView(_ tableView: UITableView, didHighlightRow row: Int) {}
    open func tableView(_ tableView: UITableView, didHighlightSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, didUnhighlightRow row: Int) {}
    open func tableView(_ tableView: UITableView, didUnhighlightSubrow subrow: Int, inRow row: Int) {}
    
    //func tableView(_ tableView: UITableView, didSelectRow row: Int) {}
    open func tableView(_ tableView: UITableView, didSelectSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, didDeselectRow row: Int) {}
    open func tableView(_ tableView: UITableView, didDeselectSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle {
        
        return .none
    }
    open func tableView(_ tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle {
        
        return .none
    }
    
    open func tableView(_ tableView: UITableView, editActionsForRow row: Int) -> [UITableViewRowAction]? {
        
        return nil
    }
    open func tableView(_ tableView: UITableView, editActionsForSubrow subrow: Int, inRow row: Int) -> [UITableViewRowAction]? {
        
        return nil
    }
    
    open func tableView(_ tableView: UITableView, indentationLevelForRow row: Int) -> Int {
        
        return 0
    }
    open func tableView(_ tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int {
        
        return 0
    }
    
    open func tableView(_ tableView: UITableView, shouldShowMenuForRow row: Int) -> Bool {
        
        return false
    }
    open func tableView(_ tableView: UITableView, shouldShowMenuForSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    open func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt row: Int, withSender sender: Any?) -> Bool {
        
        return true
    }
    open func tableView(_ tableView: UITableView, canPerformAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: Any?) -> Bool {
        
        return true
    }
    
    open func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt row: Int, withSender sender: Any?) {}
    open func tableView(_ tableView: UITableView, performAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: Any?) {}
    
    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRow row: Int) -> Bool {
        
        return false
    }
    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    open func tableView(_ tableView: UITableView, willBeginEditingRow row: Int) {}
    open func tableView(_ tableView: UITableView, willBeginEditingSubrow subrow: Int, inRow row: Int) {}
    
    open func tableView(_ tableView: UITableView, didEndEditingRow row: Int?) {}
    open func tableView(_ tableView: UITableView, didEndEditingSubrow subrow: Int?, inRow row: Int?) {}
    
    open func tableView(_ tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, to proposedDestinationRow: Int) -> Int {
        
        return sourceRow
    }
    open func tableView(_ tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, to proposedDestinationSubrow: Int, inRow row: Int) -> Int {
        
        return sourceSubrow
    }
}
