//
//  AnotherTestController.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "AnotherTestController.h"

@interface AnotherTestController ()

@property (assign) NSInteger numberOfSubrows;
@property (assign) NSInteger numberOfRows;

@end

@implementation AnotherTestController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.numberOfSubrows = 3;
    self.numberOfRows = 10;
    
    self.title = @"Another test";
    self.navigationItem.rightBarButtonItems =
    @[
    [[UIBarButtonItem alloc] initWithTitle:@"Insert"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(insertRows:)],
    [[UIBarButtonItem alloc] initWithTitle:@"Delete"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(deleteRows:)]
    ];
}

- (void)insertRows:(UIBarButtonItem *)sender {
    
    self.numberOfRows += 2;
    [self.tableView insertRowsAtRows:@[@0, @1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteRows:(UIBarButtonItem *)sender {
    
    self.numberOfRows -= 2;
    [self.tableView deleteRowsAtRows:@[@0, @1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView {
    
    return self.numberOfRows;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSubrowsInRow:(NSInteger)row {
    
    NSLog(@"%ld", (long)self.numberOfSubrows);
    
    return self.numberOfSubrows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)row];
    cell.detailTextLabel.text = nil;
    
    if (self.nsk_selectedRow) {
        
        NSInteger selectedRow = self.nsk_selectedRow.integerValue;
        
        if (row == selectedRow) {
            
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up_arrow"]];
            
        } else {
            
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow"]];
        }
    }
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubrow:(NSInteger)subrow inRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Subrow %ld", (long)row];
    cell.detailTextLabel.text = @(subrow).stringValue;
    cell.accessoryView = nil;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row {
    
    if (self.nsk_selectedRow) {
        
        NSInteger selectedRow = self.nsk_selectedRow.integerValue;
        
        if (row == selectedRow) {
            
            [tableView cellForRowAtRow:row].accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow"]];
            [tableView deselectRow:row animated:YES];
            
        } else {
            
            [tableView cellForRowAtRow:row].accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up_arrow"]];
            [tableView cellForRowAtRow:selectedRow].accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow"]];
        }
        
    } else {
        
        [tableView cellForRowAtRow:row].accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up_arrow"]];
    }
    
    [super tableView:tableView didSelectRow:row];
}

- (void)tableView:(UITableView *)tableView didSelectSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    NSLog(@"%s, %ld, %ld", __func__, (long)subrow, (long)row);
}

- (void)tableView:(UITableView *)tableView didDeselectRow:(NSInteger)row {
    
    NSLog(@"%s, %ld", __func__, (long)row);
}

- (void)tableView:(UITableView *)tableView didDeselectSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    NSLog(@"%s, %ld, %ld", __func__, (long)subrow, (long)row);
}

@end
