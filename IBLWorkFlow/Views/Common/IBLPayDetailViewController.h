//
//  IBLPayDetailViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IBLOrder.h"

typedef NS_ENUM(NSInteger,IBLOrderDetailType) {
    IBLOrderDetailTypeFromOrderCreateAccount,
    IBLOrderDetailTypeFromCreateAccount,
    IBLOrderDetailTypeFromRenew,
    IBLOrderDetailTypeFromExchangeProduct,
};

typedef NS_ENUM(NSInteger, IBLQRPayDetailType) {
    IBLQRPayDetailTypeWeChat,
    IBLQRPayDetailTypeAilPay,
};

@interface IBLPayDetailViewController : PCCWStaticTableViewController

@property (nonatomic, strong) IBLOrder *order;

@property (nonatomic, copy) NSString *orderNumber;

@property (nonatomic, assign) IBLOrderDetailType type;

@property (nonatomic, assign) IBLQRPayDetailType payModel;

@end
