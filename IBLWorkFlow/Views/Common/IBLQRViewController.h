//
//  IBLQRViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewController.h"
#import "IBLPayResult.h"

typedef NS_ENUM(NSInteger, IBLPay) {
    IBLPayWeChat,
    IBLPayAilPay,
};

@class IBLQRViewController;

@protocol IBLQRViewControllerDelegate <NSObject>

- (void)finishedPayQRViewController:(IBLQRViewController *)viewController;

@end

@interface IBLQRViewController : IBLViewController
@property (nonatomic, strong) IBLPayResult *payResult;
@property (nonatomic, assign) IBLPay pay;

@property (nonatomic, weak) id<IBLQRViewControllerDelegate> delegate;

@end
