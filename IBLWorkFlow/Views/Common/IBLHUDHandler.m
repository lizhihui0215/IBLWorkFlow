//
//  IBLHUDHandler.m
//  CMCC
//
//  Created by 李智慧 on 8/21/15.
//  Copyright (c) 2015 lizhihui. All rights reserved.
//

#import "IBLHUDHandler.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface IBLHUDHandler ()
@property (nonatomic, strong, readwrite) MBProgressHUD *hudView;
@property (nonatomic, weak, readwrite) UIViewController *loadingHandler;
@property (nonatomic, weak) UIView *loadingView;
@end

@implementation IBLHUDHandler
- (instancetype)initWithLoadingHandler:(UIViewController *)loadingHandler {
    self = [super init];
    if (self) {
        self.loadingHandler = loadingHandler;
    }

    return self;
}

+ (instancetype)handlerWithLoadingHandler:(UIViewController *)loadingHandler {
    return [[self alloc] initWithLoadingHandler:loadingHandler];
}

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view{
    [self hidenHUDFor:view];
    self.loadingView = view;
    view.userInteractionEnabled = NO;
    self.hudView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hudView.labelText = message;
}
- (void)showHUDWithMessage:(NSString *)message{
    self.loadingView = self.loadingHandler.view;
    [self showHUDWithMessage:message forView:self.loadingHandler.view];
}

- (void)hidenHUDFor:(UIView *)view{
    self.loadingView.userInteractionEnabled = YES;
    [MBProgressHUD hideHUDForView:self.loadingView animated:YES];
}

- (void)hidenHUD{
    self.loadingView.userInteractionEnabled = YES;
    [self.hudView hide:YES];
}

@end
