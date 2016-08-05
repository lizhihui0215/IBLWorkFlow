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
    IBLExchangeProductTextFieldTypeStatus,
    IBLExchangeProductTextFieldTypeUsername,
    IBLExchangeProductTextFieldTypePhone,
    IBLExchangeProductTextFieldTypeRegion,
    IBLExchangeProductTextFieldTypeFinishedDate,
    IBLExchangeProductTextFieldTypeProduct,
    IBLExchangeProductTextFieldTypeExchangeType,
    IBLExchangeProductTextFieldTypeExchangeProduct,
    IBLExchangeProductTextFieldTypeProductAmount,
    IBLExchangeProductTextFieldTypeProductCount,
    IBLExchangeProductTextFieldTypeContract,
    IBLExchangeProductTextFieldTypeTicket,
    IBLExchangeProductTextFieldTypeRenewProductCount,
    IBLExchangeProductTextFieldTypeDiscount,
    IBLExchangeProductTextFieldTypeGive,
    IBLExchangeProductTextFieldTypePay,
    IBLExchangeProductTextFieldTypeRemark,
};

@protocol IBLExchangeProductTableViewControllerDelegate <NSObject>

- (NSString *)exchangeProductText:(IBLExchangeProductTextFieldType)type;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface IBLExchangeProductTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLExchangeProductTableViewControllerDelegate> tableViewDelegate;

@end
