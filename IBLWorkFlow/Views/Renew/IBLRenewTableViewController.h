//
//  IBLRenewTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBLRenewTableViewController;
@class IBLProductPrice;
@class IBLRenewResult;

typedef NS_ENUM(NSInteger, IBLRenewTextFieldType) {
    IBLRenewTextFieldTypeAccount,
    IBLRenewTextFieldTypeState,
    IBLRenewTextFieldTypeUsername,
    IBLRenewTextFieldTypePhone,
    IBLRenewTextFieldTypeRegion,
    IBLRenewTextFieldTypeExpireDate,
    IBLRenewTextFieldTypeProduct,
    IBLRenewTextFieldTypeRenewProductCount,
    IBLRenewTextFieldTypeProductPriceAmount,
    IBLRenewTextFieldTypeProductCount,
    IBLRenewTextFieldTypeTicket,
    IBLRenewTextFieldTypeContract,
    IBLRenewTextFieldTypeDiscount,
    IBLRenewTextFieldTypeGive,
    IBLRenewTextFieldTypePay,
    IBLRenewTextFieldTypeComment,
};

@protocol IBLRenewTableViewControllerDelegate <NSObject>

- (NSString *)textOfTableViewController:(IBLRenewTableViewController *)controller type:(IBLRenewTextFieldType)type;
- (void)productPriceOfTableViewController:(IBLRenewTableViewController *)controller
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler;

- (void)tableViewController:(IBLRenewTableViewController *)controller commitResult:(IBLRenewResult *)result;
@end

@interface IBLRenewResult : NSObject

@property (nonatomic, copy) NSString *type;


@end

@interface IBLRenewTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLRenewTableViewControllerDelegate> tableViewDelegate;

@end
