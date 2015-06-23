//
//  CDZAlertHelper.h
//  IOSForX2New
//
//  Created by zhengchen2 on 15/5/6.
//  Copyright (c) 2015年 haofan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CDZAlertBlock)(NSInteger buttonIndex);

@interface CDZAlertHelper : NSObject

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
