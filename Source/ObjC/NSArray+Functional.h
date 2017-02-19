//
//  NSArray+Functional.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 16.01.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Functional)

- (NSInteger)nsk_countIf:(BOOL(^)(ObjectType obj))block;

- (NSArray *)nsk_mapUsingBlock:(id(^)(ObjectType obj))block;

- (NSArray *)nsk_flatMapUsingBlock:(id _Nullable(^)(ObjectType obj))block;

+ (NSArray<NSNumber *> *)nsk_arrayFrom:(NSInteger)from to:(NSInteger)to;

- (instancetype)nsk_reversing;

@end

NS_ASSUME_NONNULL_END
