//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductViewModel.h"
#import "IBLRelateUser.h"
#import "IBLCreateAccountHiddenFields.h"
#import "IBLAppRepository.h"
#import "IBLGenerateAppConfiguration.h"
#import "IBLExchangeProductTableViewController.h"
#import "IBLUserListRepository.h"
#import "IBLExchangeProduct.h"

@interface IBLExchangeProductViewModel ()
@property (nonatomic, strong) IBLFetchProductPrice *fetchProductPrice;

@property (nonatomic, strong) IBLProductPrice *productPrices;

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@property (nonatomic, strong) IBLPay *QRPay;

@property (nonatomic, strong, readwrite) IBLPayResult *payResult;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@property (nonatomic, strong) IBLExchangeProduct *exchangeProduct;

@end

@implementation IBLExchangeProductViewModel

- (instancetype)initWithUser:(IBLRelateUser *)user {
    self = [super init];
    if (self) {
        _user = user;
        self.fetchProductPrice = [[IBLFetchProductPrice alloc] init];
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];
        self.QRPay = [[IBLPay alloc] init];
        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
        self.exchangeProduct = [[IBLExchangeProduct alloc] init];
    }

    return self;
}

- (IBLProductPrice *)productPrice {
    return self.productPrices;
}

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)info
          completeHandler:(IBLViewModelCompleteHandler)handler {
    [self.fetchProductPrice fetchProductPrice:info
                              completeHandler:^(IBLProductPrice *productPrice, NSError *error) {
                                  self.productPrices = productPrice;
                                  handler(error);
                              }];
}


+ (instancetype)modelWithUser:(IBLRelateUser *)user {
    return [[self alloc] initWithUser:user];
}

- (NSString *)account {
    return self.user.account;
}

- (NSString *)productIdentifier{
    return self.user.offerIdentifier;
}


- (NSString *)status {
    return self.user.state;
}

- (NSString *)username {
    return self.user.username;
}

- (NSString *)phone {
    return self.user.phone;
}

- (NSString *)region {
    return self.user.areaName;
}

- (NSString *)regionIdentifier{
    return self.user.areaIdentifier;
}

- (NSString *)finishedDate {
    return self.user.expDate;
}

- (NSString *)product {
    return self.user.offerName;
}

- (IBLPayModel)payModel {
    return [self.generateAppConfiguration payModel];
}

- (void)payWithType:(NSString *)type
             result:(IBLExchangeProductResult *)result
    completeHandler:(IBLViewModelCompleteHandler)handler {
    
    IBLQRPayInfo *info = [[IBLQRPayInfo alloc] init];
    
    info.orderType = @"3";
    
    info.payType = type;
    
    info.offerId = [@(result.product.identifier) stringValue];
    
    info.account = self.user.account;
    
    //    info.password = self.;
    
    info.userName = self.user.username;
    
    info.phone = self.user.phone;
    
    info.addr = self.user.address;
    
    info.remark = result.comment;
    
    info.extraLength = result.discount * 100;
    
    info.offerName = result.product.name;
    
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

- (void)commitWithResult:(IBLExchangeProductResult *)result
         completeHandler:(IBLViewModelCompleteHandler)handler{
    IBLExchangeProductParameters *info = [[IBLExchangeProductParameters alloc] init];
    info.account = self.user.account;
    info.offerId = [@(result.product.identifier) stringValue];
    info.remark = result.comment;
    info.buyLength = result.renewProductCount;
    info.totalCost = result.productPriceAmount ;
    info.preCost = result.give;
    info.extraLength = result.discount;
    info.contractCode = result.contract;
    info.voiceCode = result.ticket;
    info.changeType = result.exchangeType;
    [self.exchangeProduct exchangeProductWithParameters:info
                                        completeHandler:^(NSString *obj, NSError *error) {
                                            handler(error);
                                        }];
}


- (NSString *)exchangeType {
   IBLAppConfiguration *appConfiguration = [IBLAppRepository appConfiguration];
    return [@(appConfiguration.changeType) stringValue];
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath {
    return [self.hiddenFields.exchangeProductHiddenFieldsDictionary[indexPath] boolValue];
}
@end
