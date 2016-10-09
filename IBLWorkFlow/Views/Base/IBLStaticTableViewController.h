//
//  IBLStaticTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 09/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLStaticTableViewController.h"

@interface IBLStaticTableViewController : UITableViewController
- (BOOL)showAlertWithError:(NSError *)error;

- (void)showAlertWithError:(NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

- (void)showHUDWithMessage:(NSString *)message;

- (void)hidHUD;

- (void)hidHUDForView:(UIView *)view;

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view;

- (void)removeFooterView;
@end
