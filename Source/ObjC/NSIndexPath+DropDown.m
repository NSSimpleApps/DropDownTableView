//
//  NSIndexPath+DropDown.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 15.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "NSIndexPath+DropDown.h"

@implementation NSIndexPath (DropDown)

+ (instancetype)indexPathForSubrow:(NSInteger)subrow inMainrow:(NSInteger)mainrow {
    
    NSUInteger indexes[] = {subrow, mainrow};
    
    return [self indexPathWithIndexes:indexes length:2];
}

- (NSInteger)mainrow {
    
    return [self indexAtPosition:0];
}

- (NSInteger)subrow {
    
    return [self indexAtPosition:1];
}

@end
