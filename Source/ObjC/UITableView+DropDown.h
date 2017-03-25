//
//  UITableView+DropDown.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DropDownIndexPath <NSObject>
@end

@interface NSNumber (DropDownIndexPath) <DropDownIndexPath>
@end

@interface NSIndexPath (DropDownIndexPath) <DropDownIndexPath>
@end


@protocol DropDownTableViewDelegate, DropDownTableViewDataSource;

@interface UITableView (DropDown)

@property (weak, nullable) id<DropDownTableViewDelegate>dropDownDelegate;
@property (weak, nullable) id<DropDownTableViewDataSource>dropDownDataSource;

- (CGRect)rectForRow:(NSInteger)row;
- (CGRect)rectForSubrowAtIndexPath:(NSIndexPath *)indexPath; // -[NSIndexPath forSubrow:inMainrow:]

/// returns NSNumber for row or -[NSIndexPath forSubrow:inMainrow:] for subrow
- (nullable id<DropDownIndexPath>)dropDownIndexPathAtPoint:(CGPoint)point;

/// returns NSNumber for row or -[NSIndexPath forSubrow:inMainrow:] for subrow
- (nullable id<DropDownIndexPath>)dropDownIndexPathForCell:(UITableViewCell *)cell;

/// returns NSNumber for row or NSIndexPath(forSubrow: Int, inMainrow: Int) for subrow
- (nullable NSArray<DropDownIndexPath> *)dropDownIndexPathsInRect:(CGRect)rect;

- (nullable __kindof UITableViewCell *)cellForRowAtRow:(NSInteger)row;
- (nullable __kindof UITableViewCell *)cellForSubrowAtIndexPath:(NSIndexPath *)indexPath; // -[NSIndexPath forSubrow:inMainrow:]

- (nullable NSArray<NSNumber *> *)visibleRows;
/// returns  @[-[NSIndexPath forSubrow:inMainrow:]]
- (nullable NSArray<NSIndexPath *> *)indexPathsForVisibleSubrows;

- (void)scrollToRowAtRow:(NSInteger)row atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSubrowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated; // -[NSIndexPath forSubrow:inMainrow:]

- (void)insertRowsAtRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteRowsAtRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadRowsAtRows:(NSArray<NSNumber *> *)rows withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSubrows:(NSArray<NSNumber *> *)subrows inRow:(NSInteger)row withRowAnimation:(UITableViewRowAnimation)animation;

- (void)moveRowAtRow:(NSInteger)row toRow:(NSInteger)newRow;
- (void)moveSubrow:(NSInteger)subrow toNewSubrow:(NSInteger)newSubrow inRow:(NSInteger)row;

/// returns NSNumber for row or NSIndexPath(forSubrow: Int, inMainrow: Int) for subrow
- (nullable id<DropDownIndexPath>)dropDownIndexPathForSelectedRow;

/// returns NSNumber for row or NSIndexPath(forSubrow: Int, inMainrow: Int) for subrow
- (nullable NSArray<DropDownIndexPath> *)dropDownIndexPathsForSelectedRows;

- (void)selectRow:(nullable NSNumber *)row animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)selectSubrowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;

- (void)deselectRow:(NSInteger)row animated:(BOOL)animated;
- (void)deselectSubrowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
