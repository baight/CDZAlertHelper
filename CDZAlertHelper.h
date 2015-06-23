//
//  CDZAlertHelper.h
//
//
//  Created by baight on 15/5/6.
//  Copyright (c) 2015年 baight All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CDZAlertBlock)(NSInteger buttonIndex);

@interface CDZAlertHelper : NSObject

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
