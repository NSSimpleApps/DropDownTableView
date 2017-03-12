//
//  DropDownTableViewController.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownTableViewDelegate.h"
#import "DropDownTableViewDataSource.h"

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

NS_ASSUME_NONNULL_BEGIN

@interface DropDownTableViewController : UITableViewController

@property (strong, nullable, readonly) NSNumber *nsk_selectedRow;
@property (assign, readonly) NSInteger nsk_numberOfSubrows;

- (NSArray<NSIndexPath *> *)tableView:(UITableView *)tableView indexPathsForRows:(NSArray<NSNumber *> *)rows;
- (NSArray<NSIndexPath *> *)tableView:(UITableView *)tableView indexPathsForSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row;

- (nullable id)valueForIndexPath:(NSIndexPath *)indexPath
                     valueForRow:(id _Nullable (^)(NSInteger row))valueForRow
                  valueForSubrow:(id _Nullable (^)(NSInteger subrow, NSInteger row))valueForSubrow;

- (void)dropDownDeleteRows:(NSArray<NSNumber *> *)rows inTableView:(UITableView *)tableView;
- (void)dropDownInsertRows:(NSArray<NSNumber *> *)rows inTableView:(UITableView *)tableView;

- (void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row;

@end


@interface DropDownTableViewController (DropDownTableViewDataSource) <DropDownTableViewDataSource>

@end

@interface DropDownTableViewController (DropDownTableViewDelegate) <DropDownTableViewDelegate>
@end

NS_ASSUME_NONNULL_END
