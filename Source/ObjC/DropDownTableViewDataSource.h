//
//  DropDownTableViewDataSource.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DropDownTableViewDataSource <NSObject>

/// object must return an array of regular indexpaths [NSIndexPath(forRow:inSection)]
- (NSArray<NSIndexPath *> *)tableView:(UITableView *)tableView indexPathsForRows:(NSArray< NSNumber *> *)rows;

/// object must return an array of regular indexpaths [IndexPath(forRow:inSection)]
- (NSArray<NSIndexPath *> *)tableView:(UITableView *)tableView indexPathsForSubrows:(NSArray< NSNumber *> *)subrows inRow:(NSInteger)row;

/// some value for row and subrow

- (nullable id)valueForIndexPath:(NSIndexPath *)indexPath
                     valueForRow:(id _Nullable(^)(NSInteger row))valueForRow
                  valueForSubrow:(id _Nullable(^)(NSInteger subrow, NSInteger row))valueForSubrow;

/// implement this method and invoke while you delete rows manually
- (void)dropDownDeleteRows:(NSArray<NSNumber *> *)rows inTableView:(UITableView *)tableView;
/// implement this method and invoke while you insert rows manually
- (void)dropDownInsertRows:(NSArray<NSNumber *> *)rows inTableView:(UITableView *)tableView;

- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubrow:(NSInteger)subrow inRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath;

//@optional
- (NSInteger)tableView:(UITableView *)tableView numberOfSubrowsInRow:(NSInteger)row; // Default is 0

// default is UITableViewRowAnimationAutomatic
- (UITableViewRowAnimation)tableView:(UITableView *)tableView animationForInsertionInRow:(NSInteger)row;
- (UITableViewRowAnimation)tableView:(UITableView *)tableView animationForDeletionInRow:(NSInteger)row;

/// define row whose subrow will be shown at initial appearance
- (nullable NSNumber *)showSubrowsInRow; // default is nil

// use tableView:titleFor{Header,Footer}InSection: for section 0. other sections are ignored
// - (nullable NSString *)titleForHeaderInTableView:(UITableView *)tableView;
// - (nullable NSString *)titleForFooterInTableView:(UITableView *)tableView;

// default is NO
- (BOOL)tableView:(UITableView *)tableView canEditRow:(NSInteger)row;
- (BOOL)tableView:(UITableView *)tableView canEditSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
           forRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forSubrow:(NSInteger)subrow
            inRow:(NSInteger)row;

// default is NO
- (BOOL)tableView:(UITableView *)tableView canMoveRow:(NSInteger)row;
- (BOOL)tableView:(UITableView *)tableView canMoveSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is nil
- (nullable UIView *)tableView:(UITableView *)tableView accessoryViewForSelectedRow:(NSInteger)row;
- (nullable UIView *)tableView:(UITableView *)tableView accessoryViewForDeselectedRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView moveRow:(NSInteger)sourceRow toDestinationRow:(NSInteger) destinationRow;
- (void)tableView:(UITableView *)tableView moveSourceSubrow:(NSInteger)sourceSubrow toDestinationSubrow:(NSInteger)destinationSubrow inRow:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
