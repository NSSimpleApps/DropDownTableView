//
//  NSIndexPath+DropDown.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

// mainrow0 /\
//    subrow0       -> IndexPath(forSubrow: 0, mainrow: 0)
//    subrow1       -> IndexPath(forSubrow: 1, mainrow: 0)
//    subrow2       -> IndexPath(forSubrow: 2, mainrow: 0)
//    subrow3       -> IndexPath(forSubrow: 3, mainrow: 0)
// mainrow1 \/


NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (DropDown)

+ (instancetype)indexPathForSubrow:(NSInteger)subrow inMainrow:(NSInteger)mainrow;

@property (assign, readonly) NSInteger mainrow;
@property (assign, readonly) NSInteger subrow;

@end

NS_ASSUME_NONNULL_END
