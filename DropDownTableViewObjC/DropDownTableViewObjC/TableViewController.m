//
//  TableViewController.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "TableViewController.h"
#import "UIAlertController+TextField.h"

@interface Pair : NSObject

@property (copy) NSString *key;
@property (copy) NSString *value;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;

@end

@implementation Pair

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value {
    
    self = [super init];
    
    if (self) {
        
        self.key = key;
        self.value = value;
    }
    
    return self;
}

@end

@interface State : NSObject

@property (copy) NSString *name;
@property (strong) NSMutableOrderedSet<Pair *> *parameters;

@end

@implementation State

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.name = @"";
        self.parameters = [NSMutableOrderedSet orderedSet];
    }
    
    return self;
}

@end

@interface TableViewController ()

@property (strong) NSMutableArray<State *> *data;

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    State *russia = [State new];
    russia.name = @"Russia";
    [russia.parameters addObject:[[Pair alloc] initWithKey:@"Capital" value:@"Moscow"]];
    [russia.parameters addObject:[[Pair alloc] initWithKey:@"Square" value:@"17 098 242"]];
    
    State *usa = [State new];
    usa.name = @"USA";
    [usa.parameters addObject:[[Pair alloc] initWithKey:@"Capital" value:@"Washington, D.C."]];
    [usa.parameters addObject:[[Pair alloc] initWithKey:@"Square" value:@"9 857 306"]];
    [usa.parameters addObject:[[Pair alloc] initWithKey:@"Independence Day" value:@"July 4"]];
    
    State *zimbabwe = [State new];
    zimbabwe.name = @"Zimbabwe";
    [zimbabwe.parameters addObject:[[Pair alloc] initWithKey:@"Capital" value:@"Harare"]];
    
    self.data = @[russia, usa, zimbabwe].mutableCopy;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return self.data.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RowCell"
//                                                            forIndexPath:indexPath];
//    cell.textLabel.text = self.data[indexPath.row].name;
//    
//    return cell;
//}

- (NSInteger)numberOfRowsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSubrowsInRow:(NSInteger)row {
    
    return self.data[row].parameters.count;
}

- (NSNumber *)showSubrowsInRow {
    
    return @0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RowCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.data[row].name;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubrow:(NSInteger)subrow inRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath {
    
    Pair *pair = [self.data[row].parameters objectAtIndex:subrow];
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"SubrowCell"
                                    forIndexPath:indexPath];
    cell.textLabel.text = pair.key;
    cell.detailTextLabel.text = pair.value;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView accessoryViewForSelectedRow:(NSInteger)row {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedImage"]];
}

- (UIView *)tableView:(UITableView *)tableView accessoryViewForDeselectedRow:(NSInteger)row {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deselectedImage"]];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRow:(NSInteger)row {
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return 3;
}

- (BOOL)tableView:(UITableView *)tableView canEditRow:(NSInteger)row {
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRow:(NSInteger)row {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.data removeObjectAtIndex:row];
        [tableView deleteRowsAtRows:@[@(row)] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.data[row].parameters removeObjectAtIndex:subrow];
        [tableView deleteSubrows:@[@(subrow)] inRow:row withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        UIAlertController *ac =
        [UIAlertController alertControllerWithTitle:@"Insert new subrow"
                                       placeholders:@[@"parameter", @"value"]
                                         completion:^(NSArray<NSString *> * _Nonnull texts) {
                                             
                                             NSString *key = texts.firstObject;
                                             NSString *value = texts.lastObject;
                                             
                                             [self.data[row].parameters insertObject:[[Pair alloc] initWithKey:key value:value]
                                                                             atIndex:0];
                                             [tableView insertSubrows:@[@0] inRow:row withRowAnimation:UITableViewRowAnimationAutomatic];
                                         }];
        
        [self presentViewController:ac animated:YES completion:nil];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRow:(NSInteger)row {
    
    return UITableViewCellEditingStyleDelete;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRow:(NSInteger)row {
    
    NSLog(@"%@, %ld", cell.textLabel.text, (long)row);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    NSLog(@"%@, %ld, %ld", cell.detailTextLabel.text, (long)row, (long)subrow);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRow:(NSInteger)row {
    
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView targetRowForMoveFromRow:(NSInteger)sourceRow toProposedDestinationRow:(NSInteger)destinationRow {
    
    return destinationRow;
}

- (NSInteger)tableView:(UITableView *)tableView targetSubrowForMoveFromSubrow:(NSInteger)sourceSubrow toProposedDestinationSubrow:(NSInteger)destinationSubrow inRow:(NSInteger)row {
    
    return destinationSubrow;
}

- (void)tableView:(UITableView *)tableView moveRow:(NSInteger)sourceRow toDestinationRow:(NSInteger)destinationRow {
    
    [self.data exchangeObjectAtIndex:sourceRow withObjectAtIndex:destinationRow];
}

- (void)tableView:(UITableView *)tableView moveSourceSubrow:(NSInteger)sourceSubrow toDestinationSubrow:(NSInteger)destinationSubrow inRow:(NSInteger)row {
    
    State *state = self.data[row];
    [state.parameters exchangeObjectAtIndex:sourceSubrow withObjectAtIndex:destinationSubrow];
}

- (UITableViewRowAnimation)tableView:(UITableView *)tableView animationForInsertionInRow:(NSInteger)row {
    
    return UITableViewRowAnimationRight;
}

- (UITableViewRowAnimation)tableView:(UITableView *)tableView animationForDeletionInRow:(NSInteger)row {
    
    return UITableViewRowAnimationLeft;
}

@end

