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

@interface IBLRenewViewModel ()

@property (nonatomic, strong) IBLFetchProductPrice *fetchProductPrice;

@property (nonatomic, strong) IBLProductPrice *productPrices;

@property (nonatomic, strong) IBLCreateAccount *createAccount;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@end

@implementation IBLRenewViewModel
- (instancetype)initWithUser:(IBLRelateUser *)user {
    self = [super init];
    if (self) {
        _user = user;
        self.fetchProductPrice = [[IBLFetchProductPrice alloc] init];
        
        self.createAccount = [[IBLCreateAccount alloc] init];

        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
        
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];

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

- (void)commitWithResult:(IBLRenewResult *)result
         completeHandler:(IBLViewModelCompleteHandler)handler{
    IBLCreateAccountInfo *info = [[IBLCreateAccountInfo alloc] init];
    info.account = self.user.account;
    info.userName = self.user.username;
    info.idNo = self.user.userIdentifier;
    info.phone = self.user.phone;
    info.addr = self.user.address;
    info.remark = self.user.comments;
    info.productId = self.user.offerIdentifier;
    info.buyLength = [@(self.productPrices.totalLength) stringValue];
    info.totalCost = result.productPriceAmount;
    info.preCost = result.discount;
    info.extraLength = result.give;
    info.nodeId = self.user.areaIdentifier;
    info.loginType = @"";
    info.contractCode = result.contract;
    info.voiceCode = result.ticket;
    
    
    [self.createAccount createAccountWithInfo:info completeHandler:^(id obj, NSError *error) {
        
    }];
}

- (IBLPayModel)payModel {
    return [self.generateAppConfiguration payModel];
}

- (NSDictionary<NSIndexPath *, NSNumber *> *)notNullFieldsDictionary {
    return [self.hiddenFields renewNotNullFieldsDictionary];
}
@end
