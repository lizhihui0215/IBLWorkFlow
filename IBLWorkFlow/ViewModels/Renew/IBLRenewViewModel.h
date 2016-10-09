//
//  IBLRenewViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewModel.h"
#import "IBLRelateUser.h"
#import "IBLFetchProductPrice.h"
#import "IBLPay.h"

@class IBLRenewResult;

@interface IBLRenewViewModel : IBLViewModel

@property (nonatomic, strong, readonly) IBLRelateUser *user;

@property (nonatomic, strong, readonly) IBLProductPrice *productPrices;

@property (nonatomic, strong, readonly) IBLPayResult *payResult;

+ (instancetype)modelWithUser:(IBLRelateUser *)user;

- (NSString *)account;

- (NSString *)state;

- (NSString *)username;

- (NSString *)pbone;

- (NSString *)regionName;

- (NSString *)expireDate;

- (NSString *)product;

- (NSString *)productCount;

- (NSString *)productPriceAmount;

- (NSString *)ticket;

- (NSString *)contract;

- (NSString *)discount;

- (NSString *)give;

- (NSString *)pay;

- (NSString *)comment;

- (NSString *)renewProductCount;

- (NSString *)productIdentifier;

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)info completeHandler:(IBLViewModelCompleteHandler)handler;

- (IBLProductPrice *)productPrice;

- (void)commitWithResult:(IBLRenewResult *)result
         completeHandler:(IBLViewModelCompleteHandler)handler;

- (IBLPayModel)payModel;

- (NSDictionary<NSIndexPath *, NSString *> *)notNullFieldsDictionary;

- (void)payWithType:(NSString *)type
             result:(IBLRenewResult *)result
    completeHandler:(IBLViewModelCompleteHandler)handler;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;
@end
