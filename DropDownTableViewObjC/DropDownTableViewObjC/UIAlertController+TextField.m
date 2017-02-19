//
//  UIAlertController+TextField.m
//  DropDownTableViewObjC
//
//  Created by NSSimpleApps on 19.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

#import "UIAlertController+TextField.h"

@interface UIAlertController (TextFieldDelegate) <UITextFieldDelegate>
@end

@implementation UIAlertController (TextFieldDelegate)

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (string.length == 0) {
        
        self.actions.firstObject.enabled = textField.text.length > 1;
        
    } else {
        
        self.actions.firstObject.enabled = textField.text.length > 0;
    }
    
    return YES;
}

@end

@implementation UIAlertController (TextField)

+ (instancetype)alertControllerWithTitle:(NSString *)title
                            placeholders:(NSArray<NSString *> *)placeholders
                              completion:(void(^)(NSArray<NSString *> *))completion {
    
    UIAlertController *ac =
    [self alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(ac) weakAc = ac;
    
    [placeholders enumerateObjectsUsingBlock:^(NSString * _Nonnull placeholder, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.placeholder = placeholder;
            
            if (idx == 0) {
                
                textField.delegate = weakAc;
            }
        }];
        
        UIAlertAction *OKAction =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   
                                   NSArray<NSString *> *texts =
                                   [ac.textFields valueForKey:@"text"];
                                   
                                   completion(texts);
                               }];
        OKAction.enabled = NO;
        
        UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleCancel
                               handler:nil];
        
        [ac addAction:OKAction];
        [ac addAction:cancelAction];
    }];
    
    return ac;
}

@end
