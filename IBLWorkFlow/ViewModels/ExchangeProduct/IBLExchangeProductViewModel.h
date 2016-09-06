//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLViewModel.h"
#import "IBLFetchProductPrice.h"
#import "IBLRelateUser.h"
#import "IBLPay.h"
@class IBLExchangeProductResult;

@interface IBLExchangeProductViewModel : IBLViewModel

@property (nonatomic, strong, readonly) IBLRelateUser *user;

@property (nonatomic, strong, readonly) IBLProductPrice *productPrices;

@property (nonatomic, strong, readonly) IBLPayResult *payResult;

+ (instancetype)modelWithUser:(IBLRelateUser *)user;

- (NSString *)account;

- (NSString *)status;

- (NSString *)username;

- (NSString *)phone;

- (NSString *)region;

- (NSString *)finishedDate;

- (NSString *)product;

- (NSString *)exchangeType;

- (NSString *)productIdentifier;

- (NSString *)regionIdentifier;

- (IBLProductPrice *)productPrice;

- (IBLPayModel)payModel;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)info
          completeHandler:(IBLViewModelCompleteHandler)handler;

- (void)payWithType:(NSString *)type
             result:(IBLExchangeProductResult *)result
    completeHandler:(IBLViewModelCompleteHandler)handler;

- (void)commitWithResult:(IBLExchangeProductResult *)result
         completeHandler:(IBLViewModelCompleteHandler)handler;
@end