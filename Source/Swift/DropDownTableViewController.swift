//
//  DropDownTableViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 25.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

////////////////////////////////////////////////
//
// row0 \/      -\
// row1 \/       | -> one section in UITableView
// row2 \/      -/
//
//
//
//
// row0 /\      -\
//    subrow0     \
//    subrow1     |
//    subrow2     | -> one section in UITableView
//    subrow3     |
// row1 \/        /
// row2 \/      -/
//
////////////////////////////////////////////////


@available(iOS 8.0, *)
@objcMembers
open class DropDownTableViewController: UITableViewController {
    
    private(set) public lazy var nsk_selectedRow: Int? = self.showSubrowsInRow
    private(set) public var nsk_numberOfSubrows = 0
    
    open func numberOfRows(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    /*optional*/ open var showSubrowsInRow: Int? {
        
        return nil
    }
    
    override public final func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = self.numberOfRows(in: tableView)
            
        if let selectedRow = self.nsk_selectedRow {
                
            self.nsk_numberOfSubrows = self.tableView(tableView, numberOfSubrowsInRow: selectedRow)
            
        } else {
                
            self.nsk_numberOfSubrows = 0
        }
                
        return numberOfRows + self.nsk_numberOfSubrows
    }
    
    open func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("-[DropDownTableViewController tableView:cellForRow:indexPath] has not been implemented")
    }
    
    open func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("-[DropDownTableViewController tableView:cellForSubrow:indexPath] has not been implemented")
    }
    
    override public final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.valueForIndexPath(indexPath,
                                      valueForRow: { (row) -> UITableViewCell in
                                            
                                            return self.tableView(tableView, cellForRow: row, indexPath: indexPath)
        },
                                      valueForSubrow: { (subrow, row) -> UITableViewCell in
                                        
                                        return self.tableView(tableView, cellForSubrow: subrow, inRow: row, indexPath: indexPath)
        })
    }
    
//    override public final func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
//    override public final func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    override public final func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Bool in
                
                return (self.nsk_numberOfSubrows == 0) && self.tableView(tableView, canEditRow: row)
            },
            valueForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, canEditSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Bool in
                
                return (self.nsk_numberOfSubrows == 0) && self.tableView(tableView, canMoveRow: row)
            },
            valueForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, canMoveSubrow: subrow, inRow: row)
        })
    }
    
    // ****************
    /*
     open override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
     }
    
     open override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {}
    */
    
    override public final func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, commitEditingStyle: editingStyle, forRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, commitEditingStyle: editingStyle, forSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if self.nsk_numberOfSubrows == 0 {
            
            let sourceRow = sourceIndexPath.row
            let destinationRow = destinationIndexPath.row
            
            self.tableView(tableView, moveRow: sourceRow, to: destinationRow)
            
        } else {
            
            let sourceSubrow = self.valueForIndexPath(sourceIndexPath,
                                                         valueForRow: { (row) -> Int? in
                                                            
                                                            return nil
                },
                                                         valueForSubrow: { (subrow, row) -> Int in
                                                            
                                                            return subrow
            })
            
            let destinationSubrow = self.valueForIndexPath(destinationIndexPath,
                                                         valueForRow: { (row) -> Int? in
                                                            
                                                            return nil
                },
                                                         valueForSubrow: { (subrow, row) -> Int in
                                                            
                                                            return subrow
            })
            
            if let sourceSubrow = sourceSubrow, let destinationSubrow = destinationSubrow, let selectedRow = self.nsk_selectedRow {
                
                self.tableView(tableView, moveSubrow: sourceSubrow,
                               to: destinationSubrow,
                               inRow: selectedRow)
            }
        }
    }
    
    override public final func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, willDisplayCell: cell, forRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, willDisplayCell: cell, forSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, willDisplayHeaderView: view)
    }
    
    override public final func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, willDisplayFooterView: view)
    }
    
    /// !!!!! NOTE: this method is not suitable for deletion and insertion any cells
    override open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
                                  valueForRow: { (row) -> Void in
                                    
                                    self.tableView(tableView, didEndDisplayingCell: cell, forRow: row)
                                    
        }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, didEndDisplayingCell: cell, forSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, didEndDisplayingHeaderView: view)
    }
    
    override public final func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, didEndDisplayingFooterView: view)
    }
    
    override public final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, heightForRow: row)
                
            },
            valueForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, heightForSubrow: subrow, inRow: row)
        })
    }
    
//    override public final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//    override public final func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    
    override public final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForRow: row)
            },
            valueForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForSubrow: subrow, inRow: row)
        })
    }
    
//    override public final func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
//    override public final func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    
//    override public final func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    override public final func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    
    override public final func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, accessoryButtonTappedForRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
                
            self.tableView(tableView, accessoryButtonTappedForSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Bool in
                
                return self.tableView(tableView, shouldHighlightRow: row)
                
            },
            valueForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, shouldHighlightSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, didHighlightRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, didHighlightSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, didUnhighlightRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, didUnhighlightSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    override public final func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    open func tableView(_ tableView: UITableView, didSelectRow row: Int) {
        
        if self.nsk_selectedRow == nil {
            
            self.nsk_selectedRow = row
            
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            let animation = self.tableView(tableView, animationForInsertionIn: row)
            
            tableView.beginUpdates()
            tableView.insertSubrows(Array(0..<count),
                                    in: row,
                                    with: animation)
            tableView.endUpdates()
            //tableView.select(row: row, animated: true, scrollPosition: .none)
            
        } else if self.nsk_selectedRow! == row { // subrows should be deleted from row
            
            let animation = self.tableView(tableView, animationForDeletionIn: row)
            
            self.nsk_selectedRow = nil
            tableView.beginUpdates()
            tableView.deleteSubrows(Array(0..<self.nsk_numberOfSubrows).reversed(),
                                    in: row,
                                    with: animation)
            tableView.endUpdates()
            //tableView.deselect(row: row, animated: true)
            
        } else { // subrows should be deleted from row and inserted into (row - deletedCount)
            
            let deselectedRow = self.nsk_selectedRow!
            self.nsk_selectedRow = nil
            
            let animationForDeletion = self.tableView(tableView, animationForDeletionIn: deselectedRow)
            
            tableView.beginUpdates()
            tableView.deleteSubrows(Array(0..<self.nsk_numberOfSubrows).reversed(),
                                    in: deselectedRow,
                                    with: animationForDeletion)
            tableView.endUpdates()
            //tableView.deselect(row: deselectedRow, animated: true)
            
            self.nsk_selectedRow = row
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            let animationForInsertion = self.tableView(tableView, animationForInsertionIn: row)
            
            tableView.beginUpdates()
            tableView.insertSubrows(Array(0..<count),
                                    in: row,
                                    with: animationForInsertion)
            tableView.endUpdates()
            //tableView.select(row: row, animated: true, scrollPosition: .none)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
                               valueForRow: { (row) -> Void in
                                
                                self.tableView(tableView, didSelectRow: row)
                                    
        }, valueForSubrow: { (subrow, row) -> Void in
            
            self.tableView(tableView, didSelectSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, didDeselectRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
            
            self.tableView(tableView, didDeselectSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> UITableViewCellEditingStyle in
                
                self.tableView(tableView, editingStyleForRow: row)
                
        }, valueForSubrow: { (subrow, row) -> UITableViewCellEditingStyle in
                
                self.tableView(tableView, editingStyleForSubrow: subrow, inRow: row)
        })
    }
    
    // ****************
    /*open override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
    }*/
    
    override public final func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        return self.valueForIndexPath(indexPath,
                                      valueForRow: { (row) -> [UITableViewRowAction]? in
                                            
                                        return self.tableView(tableView, editActionsForRow: row)
                                            
            },
                                      valueForSubrow: { (subrow, row) -> [UITableViewRowAction]? in
                
                                        return self.tableView(tableView, editActionsForSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Bool in
                
                self.tableView(tableView, shouldIndentWhileEditingRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Bool in
                
                self.tableView(tableView, shouldIndentWhileEditingSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
        self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Void in
                
                self.tableView(tableView, willBeginEditingRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, willBeginEditingSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
        if let indexPath = indexPath {
            
            self.valueForIndexPath(indexPath,
                                   valueForRow: { (row) -> Void in
                                    
                                    self.tableView(tableView, didEndEditingRow: row)
                                    
            }, valueForSubrow: { (subrow, row) -> Void in
                
                self.tableView(tableView, didEndEditingSubrow: subrow, inRow: row)
            })
            
        } else {
            
            if let selectedRow = self.nsk_selectedRow, self.nsk_numberOfSubrows > 0 {
                
                self.tableView(tableView, didEndEditingSubrow: nil, inRow: selectedRow)
                
            } else {
                
                self.tableView(tableView, didEndEditingRow: nil)
            }
        }
    }
    
    override public final func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if self.nsk_numberOfSubrows == 0 {
            
            let targetForRow = self.tableView(tableView, targetRowForMoveFromRow: sourceIndexPath.row,
                to: proposedDestinationIndexPath.row)
            
            return IndexPath(row: targetForRow, section: 0)
            
        } else {
            
            let _sourceSubrow = self.valueForIndexPath(sourceIndexPath,
                                      valueForRow: { (row) -> Int? in
                                        
                                        return nil
                                        
                }, valueForSubrow: { (subrow, row) -> Int in
                    
                    return subrow
            })
            
            let _proposedSubrow = self.valueForIndexPath(proposedDestinationIndexPath,
                                                   valueForRow: { (row) -> Int? in
                                                    
                                                    return nil
                                                    
                }, valueForSubrow: { (subrow, row) -> Int in
                    
                    return subrow
            })
            
            if let proposedSubrow = _proposedSubrow, let sourceSubrow = _sourceSubrow, let selectedRow = self.nsk_selectedRow {
                
                let targetSubrow = self.tableView(tableView,
                                                  targetSubrowForMoveFromSubrow: sourceSubrow,
                                                  to: proposedSubrow,
                                                  inRow: selectedRow)
                
                return IndexPath(row: targetSubrow + selectedRow + 1, section: 0)
                
            } else {
                
                return sourceIndexPath
            }
        }
    }
    
    override public final func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        return self.valueForIndexPath(indexPath,
            valueForRow: { (row) -> Int in
                
                self.tableView(tableView, indentationLevelForRow: row)
                
        }, valueForSubrow: { (subrow, row) -> Int in
                
                self.tableView(tableView, indentationLevelForSubrow: subrow, inRow: subrow)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        
        return self.valueForIndexPath(indexPath,
                                      valueForRow: { (row) -> Bool in
                                            
                                            self.tableView(tableView, shouldShowMenuForRow: row)
                                            
        }, valueForSubrow: { (subrow, row) -> Bool in
            
            self.tableView(tableView, shouldShowMenuForSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        return self.valueForIndexPath(indexPath,
                                      valueForRow: { (row) -> Bool in
                                        
                                        return self.tableView(tableView, canPerformAction: action, forRowAt: row, withSender: sender)
                                            
        }, valueForSubrow: { (subrow, row) -> Bool in
            
            self.tableView(tableView, canPerformAction: action, forSubrow: subrow, inRow: row, withSender: sender)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        
        return self.valueForIndexPath(indexPath,
                                      valueForRow: { (row) -> Void in
                                        
                                        self.tableView(tableView, performAction: action, forRowAt: row, withSender: sender)
                                            
        }, valueForSubrow: { (subrow, row) -> Void in
            
            self.tableView(tableView, performAction: action, forSubrow: subrow, inRow: row, withSender: sender)
        })
    }
    
    
    open func tableView(_ tableView: UITableView, indexPathsForRows rows: [Int]) -> [IndexPath] {
        
        if let selectedRow = self.nsk_selectedRow, self.nsk_numberOfSubrows > 0 {
            
            return rows.map({ (row: Int) -> IndexPath in
                
                if row <= selectedRow {
                    
                    return IndexPath(row: row, section: 0)
                    
                } else {
                    
                    //return IndexPath(row: row + self.nsk_numberOfSubrows + 1, section: 0)
                    return IndexPath(row: row + self.nsk_numberOfSubrows, section: 0)
                }
            })
            
        } else {
            
            return rows.map({ (row: Int) -> IndexPath in
                
                IndexPath(row: row, section: 0)
            })
        }
    }
    
    open func tableView(_ tableView: UITableView, indexPathsForSubrows subrows: [Int], inRow row: Int) -> [IndexPath] {
        
        if self.nsk_selectedRow == row && self.nsk_numberOfSubrows > 0 {
            
            return subrows.flatMap({ (subrow: Int) -> IndexPath? in
                
                if subrow < self.nsk_numberOfSubrows {
                    
                    return IndexPath(row: row + subrow + 1, section: 0)
                    
                } else {
                    
                    return nil
                }
            })
            
        } else {
            
            return []
        }
    }
    
    open func valueForIndexPath<T>(_ indexPath: IndexPath,
                                   valueForRow: (_ row: Int) -> T,
                                   valueForSubrow: (_ subrow: Int, _ row: Int) -> T) -> T {
        
        let row = indexPath.row
        
        switch (self.nsk_selectedRow, self.nsk_numberOfSubrows) {
        case (let selectedRow?, _) where row <= selectedRow:
            fallthrough
            
        case (_, 0):
            fallthrough
            
        case (nil, _):
            return valueForRow(row)
            
        case (let selectedRow?, let n) where row > selectedRow && row <= (selectedRow + n):
            return valueForSubrow(row - selectedRow - 1, selectedRow)
            
        default:
            return valueForRow(row - self.nsk_numberOfSubrows)
        }
    }
    
    open func dropDownDeleteRows(_ rows: [Int], in tableView: UITableView) {
        
        if let selectedRow = self.nsk_selectedRow {
            
            if rows.contains(selectedRow) {
                
                self.nsk_selectedRow = nil
                
            } else {
                
                let count = rows.countIf({ (elem: Int) -> Bool in
                    
                    elem < selectedRow
                })
                self.nsk_selectedRow! -= count
            }
        }
    }
    
    open func dropDownInsertRows(_ rows: [Int], in tableView: UITableView) {
        
        if let selectedRow = self.nsk_selectedRow {
            
            let count = rows.countIf({ (elem: Int) -> Bool in
                
                elem <= selectedRow
            })
            self.nsk_selectedRow! += count
        }
    }
}

private extension Array where Element: BinaryInteger {
    
    func countIf(_ predicate: (Array.Iterator.Element) throws -> Bool) rethrows -> Int {
        
        return try self.reduce(0) { (index: Int, elem: Array.Iterator.Element) -> Int in
            
            return index + (try predicate(elem) ? 1 : 0)
        }
    }
}
