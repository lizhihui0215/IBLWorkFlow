//
//  IBLExchangeProductTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBLExchangeProductTableViewController;
@class IBLProductPrice;
@class IBLExchangeProductResult;
@class IBLProduct;

typedef NS_ENUM(NSInteger, IBLExchangeProductTextFieldType) {
    IBLExchangeProductTextFieldTypeAccount,
    IBLExchangeProductTextFieldTypeStatus,
    IBLExchangeProductTextFieldTypeUsername,
    IBLExchangeProductTextFieldTypePhone,
    IBLExchangeProductTextFieldTypeRegion,
    IBLExchangeProductTextFieldTypeRegionIdentifier,
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

- (void)tableViewController:(IBLExchangeProductTableViewController *)controller commitResult:(IBLExchangeProductResult *)result;

- (void)productPriceOfTableViewController:(IBLExchangeProductTableViewController *)controller
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface IBLExchangeProductResult : NSObject;

@property (nonatomic, copy) NSString *exchangeType;
@property (nonatomic, copy) NSString *renewProductCount;
@property (nonatomic, copy) NSString *productPriceAmount;
@property (nonatomic, copy) NSString *productCount;
@property (nonatomic, copy) NSString *ticket;
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *give;
@property (nonatomic, copy) NSString *pay;
@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong) IBLProduct *product;

@end

@interface IBLExchangeProductTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLExchangeProductTableViewControllerDelegate> tableViewDelegate;

@end
