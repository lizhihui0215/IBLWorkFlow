//
//  IBLAlertController.m
//  CMCC
//
//  Created by 李智慧 on 11/22/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import "IBLAlertController.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"

@interface IBLAlertController ()
@property (nonatomic, strong) id alertView;
@property (nonatomic, assign) IBLAlertStyle stype;
@end
@implementation IBLAlertController

- (void)alertWithTitle:(NSString *)inTitle
               message:(NSString *)inMessage
      cancelButtonItem:(IBLButtonItem *)inCancelButtonItem
       otherButtonItem:(IBLButtonItem *)otherButtonItem
      otherButtonItems:(va_list)otherButtonItems

{
    if ([UIAlertController class]){
        UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:inTitle
                                                                                  message:inMessage
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        IBLButtonItem *eachItem;
        if (otherButtonItem)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonItem.label
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (otherButtonItem.action)
                                                                   otherButtonItem.action(otherButtonItem);
                                                           }];
            [alertController addAction:action];
            while((eachItem = va_arg(otherButtonItems, IBLButtonItem *)))
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:eachItem.label
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (eachItem.action)
                                                                       eachItem.action(eachItem);
                                                               }];
                [alertController addAction:action];
            }
        }
        
        if(inCancelButtonItem){
            UIAlertAction *action = [UIAlertAction actionWithTitle:inCancelButtonItem.label
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (inCancelButtonItem.action)
                                                                   inCancelButtonItem.action(inCancelButtonItem);
                                                           }];
            [alertController addAction:action];
        }
        
        
        self.alertView = alertController;
        
        
        
    }else{
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:inTitle
                                                            message:inMessage
                                                   cancelButtonItem:inCancelButtonItem otherButtonItem:otherButtonItem
                                                   otherButtonItems:otherButtonItems];
        #pragma clang diagnostic pop
        self.alertView = alertView;
    }
}

- (void)actionSheetWithTitle:(NSString *)inTitle
               message:(NSString *)inMessage
      cancelButtonItem:(IBLButtonItem *)inCancelButtonItem
       otherButtonItem:(IBLButtonItem *)otherButtonItem
      otherButtonItems:(va_list)otherButtonItems

{
    if ([UIAlertController class]){
        UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:inTitle
                                                                                  message:inMessage
                                                                           preferredStyle:UIAlertControllerStyleActionSheet];
        IBLButtonItem *eachItem;
        if (otherButtonItem)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonItem.label
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (otherButtonItem.action)
                                                                   otherButtonItem.action(otherButtonItem);
                                                           }];
            [alertController addAction:action];
            while((eachItem = va_arg(otherButtonItems, IBLButtonItem *)))
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:eachItem.label
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (eachItem.action)
                                                                       eachItem.action(eachItem);
                                                               }];
                [alertController addAction:action];
            }
        }
        
        if(inCancelButtonItem){
            UIAlertAction *action = [UIAlertAction actionWithTitle:inCancelButtonItem.label
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (inCancelButtonItem.action)
                                                                   inCancelButtonItem.action(inCancelButtonItem);
                                                           }];
            [alertController addAction:action];
        }
        
        
        self.alertView = alertController;
        
        
        
    }else{
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIActionSheet *alertView = [[UIActionSheet alloc] initWithTitle:inTitle
                                                            message:inMessage
                                                   cancelButtonItem:inCancelButtonItem otherButtonItem:otherButtonItem
                                                   otherButtonItems:otherButtonItems];
        #pragma clang diagnostic pop
        self.alertView = alertView;
    }
}

- (instancetype)initWithStyle:(IBLAlertStyle)style
                        title:(NSString *)title
                      message:(NSString *)message
             cancleButtonItem:(IBLButtonItem *)cancleButtonItem
             otherButtonItems:(IBLButtonItem *)inOtherButtonItems, ... {
    self = [super init];
    if (self) {
        self.stype = style;
        va_list argumentList;
        va_start(argumentList, inOtherButtonItems);
        if (self.stype == IBLAlertStyleActionSheet) {
            [self actionSheetWithTitle:title
                               message:message
                      cancelButtonItem:cancleButtonItem
                       otherButtonItem:inOtherButtonItems
                      otherButtonItems:argumentList];
        }else{
            [self alertWithTitle:title
                         message:message
                cancelButtonItem:cancleButtonItem
                 otherButtonItem:inOtherButtonItems
                otherButtonItems:argumentList];
        }
        va_end(argumentList);
        
    }
    return self;
}

- (void)showInController:(UIViewController *)viewController{
    if ([UIAlertController class]){
        [viewController presentViewController:self.alertView animated:YES completion:nil];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
    }else if([self.alertView isKindOfClass:[UIActionSheet class]]){
    #pragma clang diagnostic pop
        [self.alertView showInView:viewController.view];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
    }else if ([self.alertView isKindOfClass:[UIAlertView class]]){
    #pragma clang diagnostic pop
        [self.alertView show];
    }
    
}


@end
