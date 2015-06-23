//
//  CDZAlertHelper.m
//
//
//  Created by baight on 15/5/6.
//  Copyright (c) 2015年 baight. All rights reserved.
//

#import "CDZAlertHelper.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"

@implementation CDZAlertHelper

+(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
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
    if([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedAscending){
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
        
        UIViewController* c = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        if(c.presentedViewController){
            [c.presentedViewController presentViewController:ac animated:YES completion:nil];
        }
        else{
            [c presentViewController:ac animated:YES completion:nil];
        }
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

+(void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message clickBlock:(CDZAlertBlock)clickBlock  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
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
    if([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedAscending){
        UIAlertController* ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
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
        UIViewController* c = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        if(c.presentedViewController){
            [c.presentedViewController presentViewController:ac animated:YES completion:nil];
        }
        else{
            [c presentViewController:ac animated:YES completion:nil];
        }
    }
    // 8.0以下
    else{
        [UIActionSheet presentOnView:[UIApplication sharedApplication].keyWindow withTitle:title otherButtons:otherButtonTitleArray onCancel:^(UIActionSheet * ac) {
            if(clickBlock){
                clickBlock(0);
            }
        } onClickedButton:^(UIActionSheet * ac, NSUInteger index) {
            if(clickBlock){
                clickBlock(index);
            }
        }];
    }
}

@end
