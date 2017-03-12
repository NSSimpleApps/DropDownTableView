//
//  DropDownTableViewController.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "DropDownTableViewController.h"
#import "NSArray+Functional.h"
#import "UITableView+DropDown.h"

@interface DropDownTableViewController ()

@property (strong, nullable, readwrite) NSNumber *nsk_selectedRow;
@property (assign, readwrite) NSInteger nsk_numberOfSubrows;

@end

@implementation DropDownTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    
    if (self) {
        
        self.nsk_selectedRow = [self showSubrowsInRow];
    }
    
    return self;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.nsk_selectedRow = [self showSubrowsInRow];
    }
    
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.nsk_selectedRow = [self showSubrowsInRow];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows = [self numberOfRowsInTableView:tableView];
    
    if (self.nsk_selectedRow != nil) {
        
        NSInteger selectedRow = self.nsk_selectedRow.integerValue;
        
        self.nsk_numberOfSubrows = [self tableView:tableView numberOfSubrowsInRow:selectedRow];
        
    } else {
        
        self.nsk_numberOfSubrows = 0;
    }
    
    return numberOfRows + self.nsk_numberOfSubrows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [self valueForIndexPath:indexPath
                valueForRow:^UITableViewCell * _Nullable(NSInteger row) {
                    
                    return [self tableView:tableView cellForRow:row indexPath:indexPath];
                    
                }
             valueForSubrow:^UITableViewCell * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return [self tableView:tableView cellForSubrow:subrow inRow:row indexPath:indexPath];
             }];
}

// - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// - (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    BOOL result = (self.nsk_numberOfSubrows == 0) && [self tableView:tableView canEditRow:row];
                    
                    return @(result);
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView canEditSubrow:subrow inRow:row]);
                 
             }] boolValue];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    BOOL result = (self.nsk_numberOfSubrows == 0) && [self tableView:tableView canMoveRow:row];
                    
                    return @(result);
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView canMoveSubrow:subrow inRow:row]);
                 
             }] boolValue];
}

// ****************
/*
 open override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
 return nil
 }
 
 open override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {}
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                    
                    [self tableView:tableView commitEditingStyle:editingStyle forRow:row];
                    
                    return nil;
                }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView commitEditingStyle:editingStyle forSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    if (self.nsk_numberOfSubrows == 0) {
        
        NSInteger sourceRow = sourceIndexPath.row;
        NSInteger destinationRow = destinationIndexPath.row;
        
        [self tableView:tableView moveRow:sourceRow toDestinationRow:destinationRow];
        
    } else {
        
        NSNumber *sourceSubrow =
        [self valueForIndexPath:sourceIndexPath
                    valueForRow:^NSNumber * _Nullable(NSInteger row) {
                        
                        return nil;
                    }
                 valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                     
                     return @(subrow);
                 }];
        
        NSNumber *destinationSubrow =
        [self valueForIndexPath:destinationIndexPath
                    valueForRow:^NSNumber * _Nullable(NSInteger row) {
                        
                        return nil;
                    }
                 valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                     
                     return @(subrow);
                 }];
        
        if (sourceSubrow != nil && destinationSubrow != nil && self.nsk_selectedRow != nil) {
            
            [self tableView:tableView
           moveSourceSubrow:sourceSubrow.integerValue
        toDestinationSubrow:destinationSubrow.integerValue
                      inRow:self.nsk_selectedRow.integerValue];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                    
                    [self tableView:tableView willDisplayCell:cell forRow:row];
                    
                    return nil;
                }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView willDisplayCell:cell forSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    [self tableView:tableView willDisplayHeaderView:view];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
    [self tableView:tableView willDisplayFooterView:view];
}

/// !!!!! NOTE: this method is not suitable for deletion and insertion any cells
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                    
                    [self tableView:tableView didEndDisplayingCell:cell forRow:row];
                    
                    return nil;
                }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView didEndDisplayingCell:cell forSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    [self tableView:tableView didEndDisplayingHeaderView:view];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(nonnull UIView *)view forSection:(NSInteger)section {
    
    [self tableView:tableView didEndDisplayingFooterView:view];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    return @([self tableView:tableView heightForRow:row]);
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView heightForSubrow:subrow inRow:row]);
                 
             }] floatValue];
}

// - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
// - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    return @([self tableView:tableView estimatedHeightForRow:row]);
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView estimatedHeightForSubrow:subrow inRow:row]);
                 
             }] floatValue];
}

// - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
// - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section

// - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
// - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                    
                    [self tableView:tableView accessoryButtonTappedForRow:row];
                    
                    return nil;
                }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView accessoryButtonTappedForSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    return @([self tableView:tableView shouldHighlightRow:row]);
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView shouldHighlightSubrow:subrow inRow:row]);
                 
             }] boolValue];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    [self tableView:tableView didHighlightRow:row];
                    
                    return nil;
                 }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView didHighlightSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    [self tableView:tableView didUnhighlightRow:row];
                    
                    return nil;
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView didUnhighlightSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row {
    
    if (self.nsk_selectedRow == nil) {
        
        self.nsk_selectedRow = @(row);
        NSInteger count = [self tableView:tableView numberOfSubrowsInRow:row];
        UITableViewRowAnimation animation = [self tableView:tableView animationForInsertionInRow:row];
        
        [tableView beginUpdates];
        [tableView insertSubrows:[NSArray nsk_arrayFrom:0 to:count]
                           inRow:row
                withRowAnimation:animation];
        [tableView endUpdates];
        
    } else if (self.nsk_selectedRow.integerValue == row) { // subrows should be deleted from row
        
        UITableViewRowAnimation animation = [self tableView:tableView animationForDeletionInRow:row];
        self.nsk_selectedRow = nil;
        
        [tableView beginUpdates];
        [tableView deleteSubrows:[[NSArray nsk_arrayFrom:0 to:self.nsk_numberOfSubrows] nsk_reversing]
                           inRow:row
                withRowAnimation:animation];
        [tableView endUpdates];
        
    } else { // subrows should be deleted from row and inserted into (row - deletedCount)
        
        NSInteger deselectedRow = self.nsk_selectedRow.integerValue;
        self.nsk_selectedRow = nil;
        
        UITableViewRowAnimation animationForDeletion =
        [self tableView:tableView animationForDeletionInRow:deselectedRow];
        
        [tableView beginUpdates];
        [tableView deleteSubrows:[[NSArray nsk_arrayFrom:0 to:self.nsk_numberOfSubrows] nsk_reversing]
                           inRow:deselectedRow
                withRowAnimation:animationForDeletion];
        [tableView endUpdates];
        
        self.nsk_selectedRow = @(row);
        NSInteger count = [self tableView:tableView numberOfSubrowsInRow:row];
        UITableViewRowAnimation animationForInsertion =
        [self tableView:tableView animationForInsertionInRow:row];
        
        [tableView beginUpdates];
        [tableView insertSubrows:[NSArray nsk_arrayFrom:0 to:count]
                           inRow:row
                withRowAnimation:animationForInsertion];
        [tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                    
                    [self tableView:tableView didSelectRow:row];
                    
                    return nil;
                }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView didSelectSubrow:subrow inRow:row];
                 
                 return nil;
                }];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                    
                    [self tableView:tableView didDeselectRow:row];
                    
                    return nil;
                }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                 
                 [self tableView:tableView didDeselectSubrow:subrow inRow:row];
                 
                 return nil;
             }];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                 valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    return @([self tableView:tableView editingStyleForRow:row]);
                }
              valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView editingStyleForSubrow:subrow inRow:row]);
                  
             }] integerValue];
}

// ****************
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [self valueForIndexPath:indexPath
                valueForRow:^NSArray<UITableViewRowAction *> * _Nullable(NSInteger row) {
                    
                    return [self tableView:tableView editActionsForRow:row];
                 }
             valueForSubrow:^NSArray<UITableViewRowAction *> * _Nullable(NSInteger subrow, NSInteger row) {
                  
                  return [self tableView:tableView editActionsForSubrow:subrow inRow:row];
              }];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                 valueForRow:^NSNumber * _Nullable(NSInteger row) {
                     
                     return @([self tableView:tableView shouldIndentWhileEditingRow:row]);
                 }
              valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                  
                  return @([self tableView:tableView shouldIndentWhileEditingSubrow:subrow inRow:row]);
                  
              }] boolValue];
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                     
                    [self tableView:tableView willBeginEditingRow:row];
                    
                    return nil;
                 }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                  
                  [self tableView:tableView willBeginEditingSubrow:subrow inRow:row];
                 
                 return nil;
              }];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath != nil) {
        
        [self valueForIndexPath:indexPath
                    valueForRow:^id _Nullable(NSInteger row) {
                        
                        [self tableView:tableView didEndEditingRow:@(row)];
                        
                        return nil;
                    }
                 valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                     
                     [self tableView:tableView didEndEditingSubrow:@(subrow) inRow:@(row)];
                     
                     return nil;
                 }];
        
    } else {
        
        if (self.nsk_selectedRow != nil && self.nsk_numberOfSubrows > 0) {
            
            [self tableView:tableView didEndEditingSubrow:nil inRow:self.nsk_selectedRow];
            
        } else {
            
            [self tableView:tableView didEndEditingRow:nil];
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (self.nsk_numberOfSubrows == 0) {
        
        NSInteger targetForRow =
        [self tableView:tableView targetRowForMoveFromRow:sourceIndexPath.row toProposedDestinationRow:proposedDestinationIndexPath.row];
        
        return [NSIndexPath indexPathForRow:targetForRow inSection:0];
        
    } else {
        
        NSNumber *sourceSubrow =
        [self valueForIndexPath:sourceIndexPath
                    valueForRow:^NSNumber * _Nullable(NSInteger row) {
                        
                        return nil;
                        
                    }
                 valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                     
                     return @(subrow);
                 }];
        
        NSNumber *proposedSubrow =
        [self valueForIndexPath:proposedDestinationIndexPath
                    valueForRow:^NSNumber * _Nullable(NSInteger row) {
                        
                        return nil;
                    }
                 valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                     
                     return @(subrow);
                 }];
        
        if (proposedSubrow != nil && sourceSubrow != nil && self.nsk_selectedRow != nil) {
            
            NSInteger targetSubrow =
            [self tableView:tableView targetSubrowForMoveFromSubrow:sourceSubrow.integerValue toProposedDestinationSubrow:proposedSubrow.integerValue inRow:self.nsk_selectedRow.integerValue];
            
            return [NSIndexPath indexPathForRow:targetSubrow + self.nsk_selectedRow.integerValue + 1 inSection:0];
            
        } else {
            
            return sourceIndexPath;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                valueForRow:^NSNumber * _Nullable(NSInteger row) {
                    
                    return @([self tableView:tableView indentationLevelForRow:row]);
                }
             valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                 
                 return @([self tableView:tableView indentationLevelForSubrow:subrow inRow:row]);
                 
             }] integerValue];
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return
    [[self valueForIndexPath:indexPath
                 valueForRow:^NSNumber * _Nullable(NSInteger row) {
                     
                     return @([self tableView:tableView shouldShowMenuForRow:row]);
                 }
              valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                  
                  return @([self tableView:tableView shouldShowMenuForSubrow:subrow inRow:row]);
                  
              }] boolValue];
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    return
    [[self valueForIndexPath:indexPath
                 valueForRow:^NSNumber * _Nullable(NSInteger row) {
                     
                     return @([self tableView:tableView canPerformAction:action forRowAtRow:row withSender:sender]);
                 }
              valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                  
                  return @([self tableView:tableView canPerformAction:action forSubrow:subrow inRow:row withSender:sender]);
                  
              }] boolValue];
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    [self valueForIndexPath:indexPath
                valueForRow:^id _Nullable(NSInteger row) {
                     
                    [self tableView:tableView performAction:action forRowAtRow:row withSender:sender];
                    
                    return nil;
                 }
             valueForSubrow:^id _Nullable(NSInteger subrow, NSInteger row) {
                  
                  [self tableView:tableView performAction:action forSubrow:subrow inRow:row withSender:sender];
                 
                 return nil;
              }];
}

- (NSArray<NSIndexPath *> *)tableView:(UITableView *)tableView indexPathsForRows:(NSArray<NSNumber *> *)rows {
    
    NSNumber *selectedRow = self.nsk_selectedRow;
    
    if (selectedRow != nil && self.nsk_numberOfSubrows > 0) {
        
        return
        [rows nsk_mapUsingBlock:^NSIndexPath * _Nonnull(NSNumber * _Nonnull row) {
            
            if (row.integerValue <= selectedRow.integerValue) {
                
                return [NSIndexPath indexPathForRow:row.integerValue inSection:0];
                
            } else {
                
                return [NSIndexPath indexPathForRow:row.integerValue + self.nsk_numberOfSubrows
                                          inSection:0];
            }
        }];
        
    } else {
        
        return
        [rows nsk_mapUsingBlock:^NSIndexPath * _Nonnull(NSNumber * _Nonnull row) {
            
            return [NSIndexPath indexPathForRow:row.integerValue inSection:0];
        }];
    }
}

- (NSArray<NSIndexPath *> *)tableView:(UITableView *)tableView indexPathsForSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row {
    
    if (self.nsk_selectedRow.integerValue == row && self.nsk_numberOfSubrows > 0) {
        
        return
        [subrows nsk_flatMapUsingBlock:^NSIndexPath * _Nullable(NSNumber * _Nonnull subrow) {
            
            if (subrow.integerValue < self.nsk_numberOfSubrows) {
                
                return [NSIndexPath indexPathForRow:row + subrow.integerValue + 1 inSection:0];
                
            } else {
                
                return nil;
            }
        }];
        
    } else {
        
        return @[];
    }
}


- (id)valueForIndexPath:(NSIndexPath *)indexPath
            valueForRow:(id _Nullable (^)(NSInteger row))valueForRow
         valueForSubrow:(id _Nullable (^)(NSInteger subrow, NSInteger row))valueForSubrow {
    
    NSInteger row = indexPath.row;
    NSNumber *selectedRow = self.nsk_selectedRow;
    NSInteger numberOfSubrows = self.nsk_numberOfSubrows;
    
    if ((selectedRow != nil && row <= selectedRow.integerValue) ||
        (numberOfSubrows == 0) ||
        (selectedRow == nil)) {
        
        return valueForRow(row);
        
    } else if ((selectedRow != nil) &&
               (row > selectedRow.integerValue) &&
               (row <= (selectedRow.integerValue + numberOfSubrows))) {
        
        NSInteger sr = selectedRow.integerValue;
        
        return valueForSubrow(row - sr - 1, sr);
        
    } else {
        
        return valueForRow(row - numberOfSubrows);
    }
}

- (void)dropDownDeleteRows:(NSArray<NSNumber *> *)rows inTableView:(UITableView *)tableView {
    
    if (self.nsk_selectedRow != nil) {
        
        if ([rows containsObject:self.nsk_selectedRow]) {
            
            self.nsk_selectedRow = nil;
            
        } else {
            
            NSInteger selectedRow = self.nsk_selectedRow.integerValue;
            
            NSInteger count =
            [rows nsk_countIf:^BOOL(NSNumber * _Nonnull obj) {
                
                return obj.integerValue <= selectedRow;
            }];
            
            self.nsk_selectedRow = @(selectedRow - count);
        }
    }
}

- (void)dropDownInsertRows:(NSArray<NSNumber *> *)rows inTableView:(UITableView *)tableView {
    
    if (self.nsk_selectedRow != nil) {
        
        NSInteger selectedRow = self.nsk_selectedRow.integerValue;
        
        NSInteger count =
        [rows nsk_countIf:^BOOL(NSNumber * _Nonnull obj) {
            
            return obj.integerValue <= selectedRow;
        }];
        
        self.nsk_selectedRow = @(selectedRow + count);
    }
}

@end
