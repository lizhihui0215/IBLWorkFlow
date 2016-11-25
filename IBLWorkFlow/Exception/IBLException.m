//
//  IBLException.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLException.h"
#import "IBLAlertController.h"

NSString * const kExceptionCode = @"com.ibilling.iblworkflow.exception.code";

NSString * const kExceptionMessage = @"NSLocalizedDescription";

static BOOL IsShowing = NO;

@interface IBLException ()
{
    NSError *_error;
}
@property (nonatomic, weak) UIViewController *handler;
@end

@implementation IBLException

- (instancetype)initWithHandler:(UIViewController *)handler{
    self = [super init];
    if (self) {
        self.handler = handler;
    }
    return self;
}

+ (instancetype)exceptionWithHandler:(UIViewController *)handler{
    return [[self alloc] initWithHandler:handler];
}

- (BOOL)handleExceptionWithError:(NSError *)error{
    return [self handleExceptionWithError:error completeHandler:nil];
}

- (BOOL)handleExceptionWithError:(NSError *)error
                 completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler{
    _error = error;
    
    if (IsShowing || !error) {
        _error = nil;
        if(handler) handler(NO, error);
        return NO;
    }
    
    IsShowing = YES;
    
//    NSString *code = error.userInfo[kExceptionCode];
    
    NSString *message = error.userInfo[kExceptionMessage];
    
    IBLButtonItem *cancelButton = [IBLButtonItem itemWithLabel:@"确定"
                                                        action:^(IBLButtonItem *item) {
                                                            IsShowing = NO;
                                                            if(handler) handler(YES,error);
                                                            _error = nil;
                                                        }];
    
    IBLAlertController *controller = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                         title:nil
                                                                       message:message
                                                              cancleButtonItem:cancelButton
                                                              otherButtonItems:nil];
    [controller showInController:self.handler];
    
    return YES;
}

@end
