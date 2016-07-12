//
//  IBLViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBLViewController : UIViewController

- (BOOL)showAlertWithError:(NSError *)error;

- (void)showAlertWithError:(NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

- (void)showHUDWithMessage:(NSString *)message;

- (void)hidHUD;

- (void)hidHUDForView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;

@end
