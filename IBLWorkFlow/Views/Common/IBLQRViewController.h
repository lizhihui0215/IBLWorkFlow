//
//  IBLQRViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//


#import "IBLPayResult.h"
#import "IBLOrder.h"

typedef NS_ENUM(NSInteger, IBLQRPayType) {
    IBLQRPayTypeWeChat,
    IBLQRPayTypeAilPay,
};

typedef NS_ENUM(NSInteger, IBLQRType) {
    IBLQRTypeFromOrderCreateAccount,
    IBLQRTypeFromCreateAccount,
    IBLQRTypeFromRenew,
    IBLQRTypeFromExchangeProduct,
};


@class IBLQRViewController;

@protocol IBLQRViewControllerDelegate <NSObject>

- (void)finishedPayQRViewController:(IBLQRViewController *)viewController;

@end

@interface IBLQRViewController : PCCWViewController

@property (nonatomic, strong) IBLOrder *order;

@property (nonatomic, assign) IBLQRType type;

@property (nonatomic, strong) IBLPayResult *payResult;

@property (nonatomic, assign) IBLQRPayType pay;

@property (nonatomic, weak) id<IBLQRViewControllerDelegate> delegate;

@end
