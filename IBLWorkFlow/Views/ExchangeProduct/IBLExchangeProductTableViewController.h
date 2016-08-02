//
//  IBLExchangeProductTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IBLExchangeProductTextFieldType) {
    IBLExchangeProductTextFieldTypeAccount,
    IBLExchangeProductTextFieldTypeType,
    IBLExchangeProductTextFieldTypeProduct,
    IBLExchangeProductTextFieldTypeRenewProductCount,
    IBLExchangeProductTextFieldTypeProductAmout,
    IBLExchangeProductTextFieldTypeProductCount,
    IBLExchangeProductTextFieldTypeContract,
    IBLExchangeProductTextFieldTypeTicket,
    IBLExchangeProductTextFieldTypeDiscount,
    IBLExchangeProductTextFieldTypeGive,
    IBLExchangeProductTextFieldTypePay,
    IBLExchangeProductTextFieldTypeRemark,
};

@protocol IBLExchangeProductTableViewControllerDelegate <NSObject>

- (NSString *)exchangeProductText:(IBLExchangeProductTextFieldType)type;
@end

@interface IBLExchangeProductTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLExchangeProductTableViewControllerDelegate> tableViewDelegate;

@end
