//
//  CDZAlertHelper.m
//
//
//  Created by baight on 15/5/6.
//  Copyright (c) 2015年 baight All rights reserved.
//

#import "CDZAlertHelper.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"

@implementation CDZAlertHelper

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    NSMutableArray* otherButtonTitleArray = [[NSMutableArray alloc]init];
    va_list argList;
    id arg;
    if(otherButtonTitles != nil){
        [otherButtonTitleArray addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        arg = va_arg(argList, id);
        while (arg != nil){
            [otherButtonTitleArray addObject:arg];
            arg = va_arg(argList, id);
        }
        va_end(argList);
    }
    
    // 8.0 及其以上
    if([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending){
        UIAlertController* ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if(clickBlock){
                clickBlock(0);
            }
        }]];
        
        NSInteger index = 0;
        for(NSString* s in otherButtonTitleArray){
            [ac addAction:[UIAlertAction actionWithTitle:s style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(clickBlock){
                    clickBlock(index+1);
                }
            }]];
            index++;
        }
        
        UIViewController* c = [self getTopViewController];
        [c presentViewController:ac animated:YES completion:nil];
    }
    // 8.0以下
    else{
        UIAlertView* av = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
        for(NSString* buttonTitle in otherButtonTitleArray){
            [av addButtonWithTitle:buttonTitle];
        }
        if(clickBlock){
            av.tapBlock = ^(UIAlertView *alertView, NSInteger buttonIndex){
                clickBlock(buttonIndex);
            };
        }
        
        [av show];
    }
}

+(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButton:(NSString*)destructiveButton otherButtonTitles:(NSString *)otherButtonTitles, ... {
    NSMutableArray* otherButtonTitleArray = [[NSMutableArray alloc]init];
    va_list argList;
    id arg;
    if(otherButtonTitles != nil){
        [otherButtonTitleArray addObject:otherButtonTitles];
        va_start(argList, otherButtonTitles);
        arg = va_arg(argList, id);
        while (arg != nil){
            [otherButtonTitleArray addObject:arg];
            arg = va_arg(argList, id);
        }
        va_end(argList);
    }
    
    // 8.0 及其以上
    if([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending){
        UIAlertController* ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        NSInteger offest = 0;
        if(cancelButtonTitle){
            [ac addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if(clickBlock){
                    clickBlock(0);
                }
            }]];
            offest++;
        }
        
        if(destructiveButton){
            [ac addAction:[UIAlertAction actionWithTitle:destructiveButton style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                if(clickBlock){
                    clickBlock(1);
                }
            }]];
            offest++;
        }
        
        
        NSInteger index = 0;
        for(NSString* s in otherButtonTitleArray){
            [ac addAction:[UIAlertAction actionWithTitle:s style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(clickBlock){
                    clickBlock(index + offest);
                }
            }]];
            index++;
        }
        UIViewController* c = [self getTopViewController];
        [c presentViewController:ac animated:YES completion:nil];
    }
    // 8.0以下
    else{
        [UIActionSheet presentOnView:[UIApplication sharedApplication].keyWindow withTitle:title cancelButton:cancelButtonTitle destructiveButton:destructiveButton otherButtons:otherButtonTitleArray onCancel:^(UIActionSheet *ac) {
            if(clickBlock){
                clickBlock(0);
            }
        } onDestructive:^(UIActionSheet *ac) {
            if(clickBlock){
                clickBlock(1);
            }
        } onClickedButton:^(UIActionSheet *ac, NSUInteger index) {
            if(clickBlock){
                clickBlock(index);
            }
        }];
    }
}

+ (UIViewController*)getTopViewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal && !tmpWin.hidden){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] firstObject];
    UIViewController* controller = [frontView viewController];
    do{
        while (controller.presentedViewController) {
            controller = controller.presentedViewController;
        }
        if ([controller isKindOfClass:[UINavigationController class]]){
            UINavigationController* nav = (UINavigationController*)controller;
            controller = [nav topViewController];
        }
        else if ([controller isKindOfClass:[UIViewController class]]){
            controller = controller;
        }
        else{
            controller = window.rootViewController;
        }
    } while (controller.presentedViewController);
    
    return controller;
}

@end
