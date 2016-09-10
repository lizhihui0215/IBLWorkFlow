//
//  IBLRenewViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRenewViewModel.h"
#import "IBLRenewTableViewController.h"
#import "IBLCreateAccount.h"
#import "IBLGenerateAppConfiguration.h"
#import "IBLCreateAccountHiddenFields.h"
#import "IBLUserListRepository.h"
#import "IBLRenew.h"


@interface IBLRenewViewModel ()

@property (nonatomic, strong) IBLFetchProductPrice *fetchProductPrice;

@property (nonatomic, strong) IBLProductPrice *productPrices;

@property (nonatomic, strong) IBLCreateAccount *createAccount;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@property (nonatomic, strong) IBLPay *QRPay;

@property (nonatomic, strong, readwrite) IBLPayResult *payResult;

@property (nonatomic, strong) IBLRenew *renew;
@end

@implementation IBLRenewViewModel
- (instancetype)initWithUser:(IBLRelateUser *)user {
    self = [super init];
    if (self) {
        _user = user;
        self.fetchProductPrice = [[IBLFetchProductPrice alloc] init];
        
        self.createAccount = [[IBLCreateAccount alloc] init];

        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
        
        self.renew = [[IBLRenew alloc] init];
        
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];
        self.QRPay = [[IBLPay alloc] init];

    }

    return self;
}

+ (instancetype)modelWithUser:(IBLRelateUser *)user {
    return [[self alloc] initWithUser:user];
}

- (NSString *)account {
    return self.user.account;
}

- (NSString *)state {
    return self.user.state;
}

- (NSString *)username {
    return self.user.username;
}

- (NSString *)pbone {
    return self.user.phone;
}

- (NSString *)regionName {
    return self.user.areaName;
}

- (NSString *)expireDate {
    return self.user.expDate;
}

- (NSString *)product {
    return self.user.offerName;
}

- (NSString *)productIdentifier{
    return self.user.offerIdentifier;
}

- (NSString *)productCount {
    return nil;
}

- (NSString *)productPriceAmount {
    return nil;
}

- (NSString *)ticket {
    return nil;
}

- (NSString *)contract {
    return nil;
}

- (NSString *)discount {
    return nil;
}

- (NSString *)give {
    return nil;
}

- (NSString *)pay {
    return nil;
}

- (NSString *)comment {
    return self.user.comments;
}

- (NSString *)renewProductCount {
    return nil;
}

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)info
          completeHandler:(IBLViewModelCompleteHandler)handler {
    [self.fetchProductPrice fetchProductPrice:info
                              completeHandler:^(IBLProductPrice *productPrice, NSError *error) {
                                  self.productPrices = productPrice;
                                  handler(error);
                              }];
}

- (IBLProductPrice *)productPrice {
    return self.productPrices;
}

- (void)payWithType:(NSString *)type
             result:(IBLRenewResult *)result
    completeHandler:(IBLViewModelCompleteHandler)handler {
    
    IBLQRPayInfo *info = [[IBLQRPayInfo alloc] init];
    
    info.orderType = @"2";
    
    info.payType = type;
    
    info.offerId = self.productIdentifier;
    
    info.account = self.user.account;
    
//    info.password = self.;
    
    info.userName = self.user.username;
    
    info.phone = self.user.phone;
    
    info.addr = self.user.address;
    
    info.remark = result.comment;
    
    info.buyLength = result.productCount;
    
    info.extraLength = result.give;
    
    info.offerName = self.product;
    
    info.idNo = self.user.idNo;
    
    info.buyLength = result.renewProductCount;
    
    //???: 总量从那获取
    info.totalLength = result.productCount;
    
    
    info.totalCost = result.productPriceAmount;
    
    //???: payCost 从那获取
    info.payCost = result.pay;
    
    //???:
    //    info.otherCost = createAccountInfo
    
    info.nodeId = self.user.areaIdentifier;
    
    
    [self.QRPay payWithQRPayInfo:info
               completeHandler:^(IBLPayResult *payResult, NSError *error) {
                   self.payResult = payResult;
                   handler(error);
               }];
}

- (void)commitWithResult:(IBLRenewResult *)result
         completeHandler:(IBLViewModelCompleteHandler)handler{
    IBLRenewParameters *info = [[IBLRenewParameters alloc] init];
    info.servId = self.user.account;
    info.account = self.user.account;
    info.remark = self.user.comments;
    info.buyLength = [@(self.productPrices.totalLength) stringValue];
    info.totalCost = result.productPriceAmount;
    info.preCost = result.discount;
    info.extraLength = result.give;
    info.contractCode = result.contract;
    info.voiceCode = result.ticket;
    info.remark = result.comment;
    [self.renew renewWithRenewParameters:info
                         completeHandler:^(NSString *obj, NSError *error) {
                             handler(error);
                         }];
}

- (IBLPayModel)payModel {
    return [self.generateAppConfiguration payModel];
}

- (NSDictionary<NSIndexPath *, NSNumber *> *)notNullFieldsDictionary {
    return [self.hiddenFields renewNotNullFieldsDictionary];
}
@end
