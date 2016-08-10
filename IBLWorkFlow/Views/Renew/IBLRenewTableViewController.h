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

- (NSDictionary<NSIndexPath *, NSString *> *)notNullsFieldsDictionary;
@end

@interface IBLRenewResult : NSObject
@property (nonatomic, copy) NSString *renewProductCount;
@property (nonatomic, copy) NSString *productPriceAmount;
@property (nonatomic, copy) NSString *productCount;
@property (nonatomic, copy) NSString *ticket;
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *give;
@property (nonatomic, copy) NSString *pay;
@property (nonatomic, copy) NSString *comment;

+ (instancetype)resultWithRenewProductCount:(NSString *)renewProductCount
                         productPriceAmount:(NSString *)productPriceAmount
                               productCount:(NSString *)productCount
                                     ticket:(NSString *)ticket
                                   contract:(NSString *)contract
                                   discount:(NSString *)discount
                                       give:(NSString *)give
                                        pay:(NSString *)pay
                                    comment:(NSString *)comment;


@end

@interface IBLRenewTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLRenewTableViewControllerDelegate> tableViewDelegate;

@end
