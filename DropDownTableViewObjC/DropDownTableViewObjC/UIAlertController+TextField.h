//
//  UIAlertController+TextField.h
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 19.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (TextField)

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                            placeholders:(NSArray<NSString *> *)placeholders
                              completion:(void(^)(NSArray<NSString *> *))completion;


@end

NS_ASSUME_NONNULL_END
