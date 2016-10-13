//
//  IBLCreateAccountViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountViewModel.h"
#import "IBLCreateAccountHiddenFields.h"
#import "IBLGenerateAppConfiguration.h"
#import "IBLFetchProductPrice.h"
#import "IBLCreateAccount.h"
#import "IBLPay.h"
#import "IBLCreateAccountTableViewController.h"
#import "IBLUserListRepository.h"

@interface IBLCreateAccountViewModel ()

@property (nonatomic, assign, readwrite) IBLCreateAccountType createAccountType;

@property (nonatomic, strong, readwrite) IBLOrder *order;

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@property (nonatomic, strong) IBLFetchProductPrice *fetchProductPrice;

@property (nonatomic, strong) IBLProductPrice *productPrices;

@property (nonatomic, strong) IBLCreateAccount *createAccount;

@property (nonatomic, strong) IBLPay *pay;

@property (nonatomic, strong) IBLPayResult *payResult;

@end

@implementation IBLCreateAccountViewModel

- (NSMutableArray *)dataSource{
    return nil;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    
}

- (instancetype)initWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                    order:(IBLOrder *)order{
    self = [super init];
    if (self) {
        self.createAccountType = createAccountType;
        self.order = order;
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];
        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
        self.fetchProductPrice = [[IBLFetchProductPrice alloc] init];
        self.createAccount = [[IBLCreateAccount alloc] init];
        self.pay = [[IBLPay alloc] init];
    }

    return self;
}

+ (instancetype)modelWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                     order:(IBLOrder *)order{
    return [[self alloc] initWithCreateAccountType:createAccountType
                                             order:order];
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.hiddenFields createAccountHiddenFieldsDictionary][indexPath] boolValue];
}

- (IBLOrderEffectType)defaultEffectType {
    return [self.generateAppConfiguration defaultEffectType];
}

- (NSString *)defaultEffectDate {
    return [self.generateAppConfiguration defaultEffectDate];
}

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)fetchProductPrice
          completeHandler:(IBLViewModelCompleteHandler)handler {
    [self.fetchProductPrice fetchProductPrice:fetchProductPrice
                              completeHandler:^(IBLProductPrice *productPrice, NSError *error){
                                  self.productPrices = productPrice;
                                  handler(error);
                              }];
}

- (IBLProductPrice *)productPrice {
    return self.productPrices;
}

- (NSDictionary<NSIndexPath *, NSNumber *> *)notNullFieldsDictionary {
    return [self.hiddenFields createAccountNotNullFieldsDictionary];
}

- (IBLPayModel)payModel {
    return [self.generateAppConfiguration payModel];
}



- (void)createAccountWith:(IBLCreateAccountTableViewInfo *)info
          completeHandler:(void (^)(NSError *))handler {
    
    IBLCreateAccountInfo *createInfo = [[IBLCreateAccountInfo alloc] init];
    
    createInfo.account = info.account;
    createInfo.password = info.password;
    createInfo.nodeId = [@(info.residentialIdentifier) stringValue];

    createInfo.offerId = [@(info.productIdentifier) stringValue];
    createInfo.userName = info.username;
    
   createInfo.idNo = info.identifierNumber;
   createInfo.remark = info.remark;
   createInfo.effType = [@(info.effectType) stringValue];
   createInfo.effDate = info.effectDate;
   createInfo.phone = info.phone;
   createInfo.addr = info.address;
//    info.handleMark;
   createInfo.account = info.account;
   createInfo.password = info.password;
   createInfo.buyLength = info.count;
//    info.sales;
//    info.salesCount;
   createInfo.contractCode = info.contractNumebr;
   createInfo.voiceCode = info.ticketNumber;
   createInfo.preCost = info.give * 100;
   createInfo.extraLength = info.discount * 100;
   createInfo.totalCost = info.pay * 100;
    
    
    [self.createAccount createAccountWithInfo:createInfo
                              completeHandler:^(id obj, NSError *error) {
                                  handler(error);
                              }];
}

- (void)payWithType:(NSString *)type createAccountInfo:(IBLCreateAccountTableViewInfo *)createAccountInfo completeHandler:(IBLViewModelCompleteHandler)handler {
    
    IBLQRPayInfo *info = [[IBLQRPayInfo alloc] init];
    
    info.orderType = @"1";
    
    info.payType = type;
    
    info.offerId = [@(createAccountInfo.productIdentifier) stringValue];
    
    info.account = createAccountInfo.account;
    
    info.password = createAccountInfo.password;
    
    info.userName = createAccountInfo.username;
    
    info.phone = createAccountInfo.phone;
    
    info.addr = createAccountInfo.address;
    
    info.remark = createAccountInfo.remark;
    
    info.buyLength = createAccountInfo.count * 100;
    
    info.extraLength = createAccountInfo.discount * 100;
    
    //???: 总量从那获取
    info.totalLength = createAccountInfo.salesCount;
    
    
    info.totalCost = createAccountInfo.sales * 100;
    
    //???: payCost 从那获取
    info.payCost = createAccountInfo.pay * 100;
    
    //???:
//    info.otherCost = createAccountInfo
    
    info.nodeId = [@(createAccountInfo.residentialIdentifier) stringValue];
    
    
    [self.pay payWithQRPayInfo:info
               completeHandler:^(IBLPayResult *payResult, NSError *error) {
                   self.payResult = payResult;
                   handler(error);
               }];
}

@end
