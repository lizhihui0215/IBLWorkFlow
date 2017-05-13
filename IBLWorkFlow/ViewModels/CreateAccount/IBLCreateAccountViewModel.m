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
#import "IBLHandleOrder.h"

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

@property (nonatomic, strong) IBLHandleOrder *handleOrder;

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
        self.handleOrder = [[IBLHandleOrder alloc] init];
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
   createInfo.preCost = info.discount;
   createInfo.extraLength = info.give;
   createInfo.totalCost = info.pay;
    createInfo.custType = info.userType;
    createInfo.comName = info.companyName;
    createInfo.comContact = info.companyContact;
    createInfo.comContactPhone = info.companyPhone;
    createInfo.comAddr = info.companyAddress;
    createInfo.sampleComName = info.sampleComName;
    createInfo.certType = info.certType;
    
    
    
    [self.createAccount createAccountWithInfo:createInfo
                              completeHandler:^(id obj, NSError *error) {
                                  if (error) {handler(error); return ;}
                                  if (self.order.bizType == IBLWorkOrderBizStatusInstall && ![NSString isNull:obj]) {
                                      [self.handleOrder handleOrderWithOrder:self.order
                                                                  markHandle:@"1"
                                                                      servId:obj
                                                                     content:@"已开户"
                                                             completeHandler:^(NSError *error) {
                                          handler(error);
                                      }];
                                      return;
                                  }
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
    
    info.buyLength = createAccountInfo.count;
    
    info.extraLength = createAccountInfo.give;
    
    //???: 总量从那获取
    info.totalLength = createAccountInfo.salesCount;
    
    
    info.totalCost = createAccountInfo.sales;
    
    //???: payCost 从那获取
    info.payCost = createAccountInfo.pay;
    
    //???:
    info.otherCost = [@(0 - createAccountInfo.discount) stringValue];
    
    info.nodeId = [@(createAccountInfo.residentialIdentifier) stringValue];
    
    info.custType = createAccountInfo.userType;
    
    info.idNo = createAccountInfo.identifierNumber;
    
    info.comName = createAccountInfo.companyName;
    info.comContact = createAccountInfo.companyContact;
    info.comContactPhone = createAccountInfo.companyPhone;
    info.comAddr = createAccountInfo.companyAddress;
    info.sampleComName = createAccountInfo.sampleComName;
    info.certType = createAccountInfo.certType;
    
    
    
    [self.pay payWithQRPayInfo:info
               completeHandler:^(IBLPayResult *payResult, NSError *error) {
                   self.payResult = payResult;
                   handler(error);
               }];
}

@end
