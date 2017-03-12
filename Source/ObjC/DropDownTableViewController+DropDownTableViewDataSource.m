//
//  DropDownTableViewController+DropDownTableViewDataSource.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "DropDownTableViewController.h"

@implementation DropDownTableViewController (DropDownTableViewDataSource)

- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    NSAssert(NO, @"%@ has not been implemented.", NSStringFromSelector(_cmd));
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubrow:(NSInteger)subrow inRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    NSAssert(NO, @"%@ has not been implemented.", NSStringFromSelector(_cmd));
    
    return nil;
}

- (UITableViewRowAnimation)tableView:(UITableView *)tableView animationForInsertionInRow:(NSInteger)row {
    
    return UITableViewRowAnimationAutomatic;
}

- (UITableViewRowAnimation)tableView:(UITableView *)tableView animationForDeletionInRow:(NSInteger)row {
    
    return UITableViewRowAnimationAutomatic;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSubrowsInRow:(NSInteger)row {
    
    return 0;
}

- (NSNumber *)showSubrowsInRow {
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRow:(NSInteger)row {
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRow:(NSInteger)row {}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (BOOL)tableView:(UITableView *)tableView canMoveRow:(NSInteger)row {
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRow:(NSInteger)sourceRow toDestinationRow:(NSInteger)destinationRow {}

- (void)tableView:(UITableView *)tableView moveSourceSubrow:(NSInteger)sourceSubrow toDestinationSubrow:(NSInteger)destinationSubrow inRow:(NSInteger)row {}

@end
