//
//  TestViewController.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "TestViewController.h"

@interface NSDate (CustomFormat)

- (NSString *)customDateFormat;

@end

@implementation NSDate (CustomFormat)

- (NSString *)customDateFormat {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"d MMM YYYY";
    
    return [dateFormatter stringFromDate:self];
}

@end

@interface TestViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (assign) NSInteger value;
@property (strong) NSDate *date;

@end

@implementation TestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.title = @"Test";
        
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
    self.value = [userDefaults integerForKey:@"value"];
    
    self.date = [NSDate date];
    
    NSDate *date = [userDefaults objectForKey:@"date"];
    
    if (date && [date isKindOfClass:[NSDate class]]) {
        
        self.date = date;
        
    } else {
        
        self.date = [NSDate date];
    }
}

- (void)dealloc {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.value forKey:@"value"];
    [userDefaults setObject:self.date forKey:@"date"];
}

- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSubrowsInRow:(NSInteger)row {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (row == 0) {
        
        cell.textLabel.text = @"Value";
        cell.detailTextLabel.text = @(self.value).stringValue;
        
    } else {
        
        cell.textLabel.text = @"Date";
        cell.detailTextLabel.text = self.date.customDateFormat;
    }
    
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
    
    UITableViewCell *cell;
    
    if (row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"PickerCell" forIndexPath:indexPath];
        
        // this is dirty hack. Don't do it anymore
        UIPickerView *pickerView = cell.contentView.subviews.firstObject;
        [pickerView selectRow:self.value inComponent:0 animated:NO];
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell" forIndexPath:indexPath];
        
        // this is dirty hack. Don't do it anymore
        UIDatePicker *datePicker = cell.contentView.subviews.firstObject;
        datePicker.date = self.date;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return 216;
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

- (IBAction)dateChanged:(UIDatePicker *)sender {
        
    self.date = sender.date;
        
    UITableViewCell *cell = [self.tableView cellForRowAtRow:1];
    
    if (cell) {
        
        cell.detailTextLabel.text = self.date.customDateFormat;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return @(row).stringValue;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.value = row;
    
    UITableViewCell *cell = [self.tableView cellForRowAtRow:0];
    
    if (cell) {
        
        cell.detailTextLabel.text = @(self.value).stringValue;
    }
}


@end
