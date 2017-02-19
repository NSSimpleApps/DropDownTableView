//
//  NSArray+Functional.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 16.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "NSArray+Functional.h"

@implementation NSArray (Functional)

- (NSInteger)nsk_countIf:(BOOL(^)(id obj))block {
    
    __block NSInteger count = 0;
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (block(obj)) {
            
            count++;
        }
    }];
    
    return count;
}

- (NSArray *)nsk_mapUsingBlock:(id(^)(id obj))block {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [result addObject:block(obj)];
    }];
    
    return [result copy];
}

- (NSArray *)nsk_flatMapUsingBlock:(id(^)(id obj))block {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id value = block(obj);
        
        if (value) {
            
            [result addObject:value];
        }
    }];
    
    return [result copy];
}

+ (NSArray<NSNumber *> *)nsk_arrayFrom:(NSInteger)from to:(NSInteger)to {
    
    NSAssert(to >= from, @"Error: 'from' (%@) must be less or equal than 'to' (%@)", @(from), @(to));
    
    NSMutableArray<NSNumber *> *result = [NSMutableArray arrayWithCapacity:to - from];
    
    for (NSInteger elem = from; elem < to; elem++) {
        
        [result addObject:@(elem)];
    }
    
    return [result copy];
}

- (instancetype)nsk_reversing {
    
    return [[self reverseObjectEnumerator] allObjects];
}

@end
