//
//  IBLRenewTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLStaticTableViewController.h"

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

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface IBLRenewResult : NSObject
@property (nonatomic, assign) NSInteger renewProductCount;
@property (nonatomic, assign) CGFloat productPriceAmount;
@property (nonatomic, assign) NSInteger productCount;
@property (nonatomic, copy) NSString *ticket;
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, assign) CGFloat discount;
@property (nonatomic, assign) CGFloat give;
@property (nonatomic, assign) CGFloat pay;
@property (nonatomic, copy) NSString *comment;

+ (instancetype)resultWithRenewProductCount:(NSInteger)renewProductCount
                         productPriceAmount:(CGFloat)productPriceAmount
                               productCount:(NSInteger)productCount
                                     ticket:(NSString *)ticket
                                   contract:(NSString *)contract
                                   discount:(CGFloat)discount
                                       give:(CGFloat)give
                                        pay:(CGFloat)pay
                                    comment:(NSString *)comment;


@end

@interface IBLRenewTableViewController : IBLStaticTableViewController

@property (nonatomic, weak) id<IBLRenewTableViewControllerDelegate> tableViewDelegate;

@end
