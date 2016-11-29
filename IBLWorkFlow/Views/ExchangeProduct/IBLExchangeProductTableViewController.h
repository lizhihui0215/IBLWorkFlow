//
//  IBLExchangeProductTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLStaticTableViewController.h"

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
                                  product:(IBLProduct *)product
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface IBLExchangeProductResult : NSObject;

@property (nonatomic, copy) NSString *exchangeType;

@property (nonatomic, assign) NSInteger renewProductCount;
/**支付总金额*/
@property (nonatomic, assign) CGFloat productPriceAmount;

@property (nonatomic, assign) NSInteger productCount;

@property (nonatomic, copy) NSString *ticket;

@property (nonatomic, copy) NSString *contract;

@property (nonatomic, assign) CGFloat discount;

@property (nonatomic, assign) NSInteger give;

@property (nonatomic, assign) CGFloat pay;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong) IBLProduct *product;

@end

@interface IBLExchangeProductTableViewController : IBLStaticTableViewController

@property (nonatomic, weak) id<IBLExchangeProductTableViewControllerDelegate> tableViewDelegate;

@end
