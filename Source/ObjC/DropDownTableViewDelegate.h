//
//  DropDownTableViewDelegate.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DropDownTableViewDelegate <NSObject>

//@optional

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view;
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view;

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view;
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view;

- (CGFloat)tableView:(UITableView *)tableView heightForRow:(NSInteger)row;
- (CGFloat)tableView:(UITableView *)tableView heightForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// use tableView:heightFor{Header,Footer}InSection: for section 0. other sections are ignored
// - (CGFloat)heightForHeaderInTableView:(UITableView *)tableView;
// - (CGFloat)heightForFooterInTableView:(UITableView *)tableView;

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRow:(NSInteger)row;
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// use tableView:estimatedHeightFor{Header,Footer}InSection: for section 0. other sections are ignored
// - (CGFloat)estimatedHeightForHeaderInTableView:(UITableView *)tableView;
// - (CGFloat)estimatedHeightForFooterInTableView:(UITableView *)tableView;

// use tableView:viewFor{Header,Footer}InSection: for section 0. other sections are ignored
// - (nullable UIView *)viewForHeaderInTableView:(UITableView *)tableView;
// - (nullable UIView *)viewForFooterInTableView:(UITableView *)tableView;

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is YES
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRow:(NSInteger)row;
- (BOOL)tableView:(UITableView *)tableView shouldHighlightSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView didHighlightRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView didHighlightSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView didUnhighlightRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView didUnhighlightSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView didSelectRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView didSelectSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView didDeselectRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView didDeselectSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is UITableViewCellEditingStyleNone
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRow:(NSInteger)row;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is nil
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRow:(NSInteger)row;
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is 0
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRow:(NSInteger)row;
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is NO
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRow:(NSInteger)row;
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForSubrow:(NSInteger)subrow inRow:(NSInteger)row;

// default is YES
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtRow:(NSInteger)row withSender:(nullable id)sender;
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forSubrow:(NSInteger)subrow inRow:(NSInteger)row withSender:(nullable id)sender;

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtRow:(NSInteger)row withSender:(nullable id)sender;
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forSubrow:(NSInteger)subrow inRow:(NSInteger)row withSender:(nullable id)sender;

// default is NO
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRow:(NSInteger)row;
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView willBeginEditingRow:(NSInteger)row;
- (void)tableView:(UITableView *)tableView willBeginEditingSubrow:(NSInteger)subrow inRow:(NSInteger)row;

- (void)tableView:(UITableView *)tableView didEndEditingRow:(nullable NSNumber *)row;
- (void)tableView:(UITableView *)tableView didEndEditingSubrow:(nullable NSNumber *)subrow inRow:(nullable NSNumber *)row;

- (NSInteger)tableView:(UITableView *)tableView targetRowForMoveFromRow:(NSInteger)sourceRow toProposedDestinationRow:(NSInteger)destinationRow; // default is sourceRow
- (NSInteger)tableView:(UITableView *)tableView targetSubrowForMoveFromSubrow:(NSInteger)sourceSubrow
toProposedDestinationSubrow:(NSInteger)destinationSubrow inRow:(NSInteger)row; // default is sourceSubrow

@end

NS_ASSUME_NONNULL_END
