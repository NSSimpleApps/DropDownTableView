//
//  UITableView+DropDown.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "UITableView+DropDown.h"
#import "DropDownTableViewDataSource.h"
#import "DropDownTableViewDelegate.h"
#import "NSIndexPath+DropDown.h"
#import "NSArray+Functional.h"

@implementation UITableView (DropDown)

- (id<DropDownTableViewDelegate>)dropDownDelegate {
    
    return (id<DropDownTableViewDelegate>)self.delegate;
}

- (void)setDropDownDelegate:(id<DropDownTableViewDelegate>)dropDownDelegate {
    
    self.delegate = (id<UITableViewDelegate>)dropDownDelegate;
}

- (id<DropDownTableViewDataSource>)dropDownDataSource {
    
    return (id<DropDownTableViewDataSource>)self.dataSource;
}

- (void)setDropDownDataSource:(id<DropDownTableViewDataSource>)dropDownDataSource {
    
    self.dataSource = (id<UITableViewDataSource>)dropDownDataSource;
}

- (CGRect)rectForRow:(NSInteger)row {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[@(row)]].firstObject;
        
        if (indexPathForRow) {
            
            return [self rectForRowAtIndexPath:indexPathForRow];
        }
    }
    return CGRectZero;
}

// IndexPath(forSubrow: Int, inMainrow: Int)
- (CGRect)rectForSubrowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForSubrow =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:@[@(indexPath.subrow)] inRow:indexPath.mainrow].firstObject;
        
        if (indexPathForSubrow) {
            
            return [self rectForRowAtIndexPath:indexPathForSubrow];
        }
    }
    return CGRectZero;
}

- (nullable id<DropDownIndexPath>)dropDownIndexPathAtPoint:(CGPoint)point {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForRow = [self indexPathForRowAtPoint:point];
        
        if (indexPathForRow) {
            
            return
            [self.dropDownDataSource valueForIndexPath:indexPathForRow
                                           valueForRow:^id<DropDownIndexPath> _Nullable(NSInteger row) {
                                               
                                               return @(row);
                                           }
                                        valueForSubrow:^id<DropDownIndexPath> _Nullable(NSInteger subrow, NSInteger row) {
                                            
                                            return [NSIndexPath indexPathForSubrow:subrow inMainrow:row];
                                        }];
        }
    }
    return nil;
}

- (nullable id<DropDownIndexPath>)dropDownIndexPathForCell:(UITableViewCell *)cell {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPath = [self indexPathForCell:cell];
        
        if (indexPath) {
            
            return
            [self.dropDownDataSource valueForIndexPath:indexPath
                                           valueForRow:^id<DropDownIndexPath> _Nullable(NSInteger row) {
                                               
                                               return @(row);
                                           }
                                        valueForSubrow:^id<DropDownIndexPath> _Nullable(NSInteger subrow, NSInteger row) {
                                            
                                            return [NSIndexPath indexPathForSubrow:subrow inMainrow:row];
                                        }];
        }
    }
    return nil;
}

- (nullable NSArray<NSNumber *> *)rowsInRect:(CGRect)rect {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPaths = [self indexPathsForRowsInRect:rect];
        
        if (indexPaths) {
            
            return
            [indexPaths nsk_flatMapUsingBlock:^id _Nullable(NSIndexPath * _Nonnull indexPath) {
                
                return
                [self.dropDownDataSource valueForIndexPath:indexPath
                                               valueForRow:^NSNumber * _Nullable(NSInteger row) {
                                                   
                                                   return @(row);
                                               }
                                            valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                                                
                                                return nil;
                                            }];
            }];
        }
    }
    return nil;
}

- (nullable NSArray<NSIndexPath *> *)indexPathsForSubrowsInRect:(CGRect)rect {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPaths = [self indexPathsForRowsInRect:rect];
        
        if (indexPaths) {
            
            return
            [indexPaths nsk_flatMapUsingBlock:^id _Nullable(NSIndexPath * _Nonnull indexPath) {
                
                return
                [self.dropDownDataSource valueForIndexPath:indexPath
                                               valueForRow:^NSIndexPath * _Nullable(NSInteger row) {
                                                   
                                                   return nil;
                                               }
                                            valueForSubrow:^NSIndexPath * _Nullable(NSInteger subrow, NSInteger row) {
                                                
                                                return [NSIndexPath indexPathForSubrow:subrow inMainrow:row];
                                            }];
            }];
        }
    }
    return nil;
}

- (nullable __kindof UITableViewCell *)cellForRowAtRow:(NSInteger)row {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[@(row)]].firstObject;
        
        if (indexPathForRow) {
            
            return [self cellForRowAtIndexPath:indexPathForRow];
        }
    }
    return nil;
}

// IndexPath(forSubrow: Int, inMainrow: Int)
- (nullable __kindof UITableViewCell *)cellForSubrowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForSubrow =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:@[@(indexPath.subrow)] inRow:indexPath.mainrow].firstObject;
        
        if (indexPathForSubrow) {
            
            return [self cellForRowAtIndexPath:indexPathForSubrow];
        }
    }
    return nil;
}

- (nullable NSArray<NSNumber *> *)visibleRows {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForVisibleRows = self.indexPathsForVisibleRows;
        
        if (indexPathsForVisibleRows) {
            
            return
            [indexPathsForVisibleRows nsk_flatMapUsingBlock:^id _Nullable(NSIndexPath * _Nonnull indexPath) {
                
                return
                [self.dropDownDataSource valueForIndexPath:indexPath
                                               valueForRow:^NSNumber * _Nullable(NSInteger row) {
                                                   
                                                   return @(row);
                                               }
                                            valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                                                
                                                return nil;
                                            }];
            }];
        }
    }
    return nil;
}

// [IndexPath(forSubrow: Int, inMainrow: Int)]
- (nullable NSArray<NSIndexPath *> *)indexPathsForVisibleSubrows {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForVisibleRows = self.indexPathsForVisibleRows;
        
        if (indexPathsForVisibleRows) {
            
            return
            [indexPathsForVisibleRows nsk_flatMapUsingBlock:^id _Nullable(NSIndexPath * _Nonnull indexPath) {
                
                return
                [self.dropDownDataSource valueForIndexPath:indexPath
                                               valueForRow:^NSIndexPath * _Nullable(NSInteger row) {
                                                   
                                                   return nil;
                                               }
                                            valueForSubrow:^NSIndexPath * _Nullable(NSInteger subrow, NSInteger row) {
                                                
                                                return [NSIndexPath indexPathForSubrow:subrow inMainrow:row];
                                            }];
            }];
        }
    }
    return nil;
}

- (void)scrollToRowAtRow:(NSInteger)row atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[@(row)]].firstObject;
        
        if (indexPathForRow) {
            
            [self scrollToRowAtIndexPath:indexPathForRow atScrollPosition:scrollPosition animated:animated];
        }
    }
}

// IndexPath(forSubrow: Int, inMainrow: Int)
- (void)scrollToSubrowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForSubrow =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:@[@(indexPath.subrow)] inRow:indexPath.mainrow].firstObject;
        
        if (indexPathForSubrow) {
            
            [self scrollToRowAtIndexPath:indexPathForSubrow atScrollPosition:scrollPosition animated:animated];
        }
    }
}

- (void)insertRowsAtRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForRows =
        [self.dropDownDataSource tableView:self indexPathsForRows:rows];
        
        if (indexPathsForRows) {
            
            [self.dropDownDataSource dropDownInsertRows:rows inTableView:self];
            [self insertRowsAtIndexPaths:indexPathsForRows withRowAnimation:animation];
        }
    }
}

- (void)insertSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSArray<NSIndexPath *> *indexPaths =
    [subrows nsk_mapUsingBlock:^NSIndexPath * _Nonnull(NSNumber * _Nonnull subrow) {
        
        return [NSIndexPath indexPathForRow:row + subrow.integerValue + 1 inSection:0];
    }];
    
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)deleteRowsAtRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForRows =
        [self.dropDownDataSource tableView:self indexPathsForRows:rows];
        
        if (indexPathsForRows) {
            
            [self.dropDownDataSource dropDownDeleteRows:rows inTableView:self];
            [self deleteRowsAtIndexPaths:indexPathsForRows withRowAnimation:animation];
        }
    }
}

- (void)deleteSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSArray<NSIndexPath *> *indexPaths =
    [subrows nsk_mapUsingBlock:^NSIndexPath * _Nonnull(NSNumber * _Nonnull subrow) {
        
        return [NSIndexPath indexPathForRow:row + subrow.integerValue + 1 inSection:0];
    }];
    
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)reloadRowsAtRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForRows =
        [self.dropDownDataSource tableView:self indexPathsForRows:rows];
        
        if (indexPathsForRows) {
            
            [self reloadRowsAtIndexPaths:indexPathsForRows withRowAnimation:animation];
        }
    }
}

- (void)reloadSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)animation {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForSubrows =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:subrows inRow:row];
        
        if (indexPathsForSubrows) {
            
            [self reloadRowsAtIndexPaths:indexPathsForSubrows withRowAnimation:animation];
        }
    }
}

- (void)moveRowAtRow:(NSInteger)row toRow:(NSInteger)newRow {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[@(row)]].firstObject;
        
        NSIndexPath *indexPathForNewRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[@(newRow)]].firstObject;
        
        if (indexPathForRow && indexPathForNewRow) {
            
            [self moveRowAtIndexPath:indexPathForRow toIndexPath:indexPathForNewRow];
        }
    }
}

- (void)moveSubrow:(NSInteger)subrow toNewSubrow:(NSInteger)newSubrow inRow:(NSInteger)row {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForSubrows =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:@[@(subrow), @(newSubrow)] inRow:row];
        
        NSIndexPath *indexPathForSubrow = indexPathsForSubrows.firstObject;
        NSIndexPath *indexPathForNewSubrow = indexPathsForSubrows.lastObject;
        
        if (indexPathForSubrow && indexPathForNewSubrow) {
            
            [self moveRowAtIndexPath:indexPathForSubrow toIndexPath:indexPathForNewSubrow];
        }
    }
}

/// returns Int for row or IndexPath(forSubrow: Int, inMainrow: Int) for subrow
- (nullable id<DropDownIndexPath>)dropDownIndexPathForSelectedRow {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForSelectedRow = self.indexPathForSelectedRow;
        
        if (indexPathForSelectedRow) {
            
            return
            [self.dropDownDataSource valueForIndexPath:indexPathForSelectedRow
                                           valueForRow:^id<DropDownIndexPath> _Nullable(NSInteger row) {
                                               
                                               return @(row);
                                           }
                                        valueForSubrow:^id<DropDownIndexPath> _Nullable(NSInteger subrow, NSInteger row) {
                                            
                                            return [NSIndexPath indexPathForSubrow:subrow inMainrow:row];
                                        }];
        }
    }
    return nil;
}

- (nullable NSArray<NSNumber *> *)rowsForSelectedRows {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForSelectedRows = self.indexPathsForSelectedRows;
        
        if (indexPathsForSelectedRows) {
            
            return
            [indexPathsForSelectedRows nsk_flatMapUsingBlock:^id _Nullable(NSIndexPath * _Nonnull indexPath) {
                
                return
                [self.dropDownDataSource valueForIndexPath:indexPath
                                               valueForRow:^NSNumber * _Nullable(NSInteger row) {
                                                   
                                                   return @(row);
                                               }
                                            valueForSubrow:^NSNumber * _Nullable(NSInteger subrow, NSInteger row) {
                                                
                                                return nil;
                                            }];
            }];
        }
    }
    return nil;
}

// IndexPath(forSubrow: Int, inMainrow: Int)
- (nullable NSArray<NSIndexPath *> *)indexPathsForSelectedSubrows {
    
    if (self.dropDownDataSource) {
        
        NSArray<NSIndexPath *> *indexPathsForSelectedRows = self.indexPathsForSelectedRows;
        
        if (indexPathsForSelectedRows) {
            
            return
            [indexPathsForSelectedRows nsk_flatMapUsingBlock:^id _Nullable(NSIndexPath * _Nonnull indexPath) {
                
                return
                [self.dropDownDataSource valueForIndexPath:indexPath
                                               valueForRow:^NSIndexPath * _Nullable(NSInteger row) {
                                                   
                                                   return nil;
                                               }
                                            valueForSubrow:^NSIndexPath * _Nullable(NSInteger subrow, NSInteger row) {
                                                
                                                return [NSIndexPath indexPathForSubrow:subrow inMainrow:row];
                                            }];
            }];
        }
    }
    return nil;
}

- (void)selectRow:(nullable NSNumber *)row animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    
    if (row != nil && self.dropDownDataSource != nil) {
        
        NSIndexPath *indexPathForRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[row]].firstObject;
        
        if (indexPathForRow) {
            
            [self selectRowAtIndexPath:indexPathForRow animated:animated scrollPosition:scrollPosition];
        }
        
    } else {
        
        [self selectRowAtIndexPath:nil animated:animated scrollPosition:scrollPosition];
    }
}

// IndexPath(forSubrow: Int, inMainrow: Int)
- (void)selectSubrowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    
    if (indexPath != nil && self.dropDownDataSource != nil) {
        
        NSIndexPath *indexPathForSubrow =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:@[@(indexPath.subrow)] inRow:indexPath.mainrow].firstObject;
        
        if (indexPathForSubrow) {
            
            [self selectRowAtIndexPath:indexPathForSubrow animated:animated scrollPosition:scrollPosition];
        }
        
    } else {
        
        [self selectRowAtIndexPath:nil animated:animated scrollPosition:scrollPosition];
    }
}

- (void)deselectRow:(NSInteger)row animated:(BOOL)animated {
    
    if (self.dropDownDataSource != nil) {
        
        NSIndexPath *indexPathForRow =
        [self.dropDownDataSource tableView:self indexPathsForRows:@[@(row)]].firstObject;
        
        if (indexPathForRow) {
            
            [self deselectRowAtIndexPath:indexPathForRow animated:animated];
        }
    }
}

// IndexPath(forSubrow: Int, inMainrow: Int)
- (void)deselectSubrowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    
    if (self.dropDownDataSource) {
        
        NSIndexPath *indexPathForSubrow =
        [self.dropDownDataSource tableView:self indexPathsForSubrows:@[@(indexPath.subrow)] inRow:indexPath.mainrow].firstObject;
        
        if (indexPathForSubrow) {
            
            [self deselectRowAtIndexPath:indexPathForSubrow animated:animated];
        }
    }
}

@end
