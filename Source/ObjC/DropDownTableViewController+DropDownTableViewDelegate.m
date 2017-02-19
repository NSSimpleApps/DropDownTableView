//
//  DropDownTableViewController+DropDownTableViewDelegate.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 21.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "DropDownTableViewController.h"

@implementation DropDownTableViewController (DropDownTableViewDelegate)

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view {}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view {}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view {}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view {}

- (CGFloat)tableView:(UITableView *)tableView heightForRow:(NSInteger)row {
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRow:(NSInteger)row {
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRow:(NSInteger)row {
    
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView didHighlightSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (void)tableView:(UITableView *)tableView didUnhighlightRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView didUnhighlightSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

//- (void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView didSelectSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (void)tableView:(UITableView *)tableView didDeselectRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView didDeselectSubrow:(NSInteger)subrow inRow:(NSInteger)row {}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRow:(NSInteger)row {
    
    return UITableViewCellEditingStyleNone;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return UITableViewCellEditingStyleNone;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRow:(NSInteger)row {
    
    return nil;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRow:(NSInteger)row {
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRow:(NSInteger)row {
    
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtRow:(NSInteger)row withSender:(nullable id)sender {
    
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forSubrow:(NSInteger)subrow inRow:(NSInteger)row withSender:(nullable id)sender {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtRow:(NSInteger)row withSender:(nullable id)sender {}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forSubrow:(NSInteger)subrow inRow:(NSInteger)row withSender:(nullable id)sender {}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRow:(NSInteger)row {
    
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingSubrow:(NSInteger)subrow inRow:(NSInteger)row {
    
    return NO;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRow:(NSInteger)row {}
- (void)tableView:(UITableView *)tableView willBeginEditingSubrow:(NSInteger)subrow inRow:(NSInteger)row {}

- (void)tableView:(UITableView *)tableView didEndEditingRow:(nullable NSNumber *)row {}
- (void)tableView:(UITableView *)tableView didEndEditingSubrow:(nullable NSNumber *)subrow inRow:(nullable NSNumber *)row {}

- (NSInteger)tableView:(UITableView *)tableView targetRowForMoveFromRow:(NSInteger)sourceRow toProposedDestinationRow:(NSInteger)destinationRow {
    
    return sourceRow;
}
- (NSInteger)tableView:(UITableView *)tableView targetSubrowForMoveFromSubrow:(NSInteger)sourceSubrow
toProposedDestinationSubrow:(NSInteger)destinationSubrow inRow:(NSInteger)row {
    
    return sourceSubrow;
}

@end
