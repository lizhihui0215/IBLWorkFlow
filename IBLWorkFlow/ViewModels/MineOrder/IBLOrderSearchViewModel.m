//
//  IBLOrderSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewModel.h"
#import "IBLGenerateAppConfiguration.h"
#import "IBLAppRepository.h"

@interface IBLOrderSearchViewModel ()

@property  (nonatomic, strong, readwrite) IBLOrderSearchResult *searchResult;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@end

@implementation IBLOrderSearchViewModel

- (void)setDataSource:(NSMutableArray *)dataSource{
    
}

- (NSMutableArray *)dataSource{
    return nil;
}

- (instancetype)initWithSearchResult:(IBLOrderSearchResult *)searchResult {
    self = [super init];
    if (self) {
        IBLAppConfiguration *appConfiguration = [IBLAppRepository appConfiguration];

        self.searchResult = searchResult;
        self.searchResult.custType = appConfiguration.custType;
        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
    }

    return self;
}

+ (instancetype)modelWithSearchResult:(IBLOrderSearchResult *)searchResult {
    return [[self alloc] initWithSearchResult:searchResult];
}

- (void)setUsername:(NSString *)username {
    self.searchResult.username = username;
}

- (void)setUserAccount:(NSString *)userAccount {
    self.searchResult.account = userAccount;
}

- (void)setWorkOrderBizType:(IBLWorkOrderBussinessType *)businessType {
    self.searchResult.bizType = businessType;
}

- (void)setWorkOrderType:(IBLWorkOrderType *)workOrderType {
    self.searchResult.type = workOrderType;
}

- (void)setUserPhone:(NSString *)userPhone {
    self.searchResult.phone = userPhone;
}
- (NSArray<IBLWorkOrderBussinessType *> *)allWorkOrderBizTypes{
    return [self.generateAppConfiguration allWorkOrderBizTypes];
}

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesStatus:(IBLWorkOrderStatus)status {
    return [self.generateAppConfiguration workOrderBizTypesWithStatus:status];
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypes {
    return [self.generateAppConfiguration workOrderTypes];
}

- (void)setStartDate:(NSString *)startDate {
    self.searchResult.startDate = startDate;
}

- (void)setEndDate:(NSString *)endDate {
    self.searchResult.endDate = endDate;
}

- (NSString *)startDate{
    return self.searchResult.startDate;
}

- (NSString *)endDate{
    return self.searchResult.endDate;
}

- (NSString *)userAccount {
    return self.searchResult.account;
}

- (NSString *)username {
    return self.searchResult.username;
}

- (NSString *)userPhone {
    return self.searchResult.phone;
}

- (NSString *)workOrderType {
    return self.searchResult.type.name;
}

- (NSString *)workOrderBizType {
    return self.searchResult.bizType.name;
}

- (void)setEnterpriseName:(NSString *)string {
    self.searchResult.comName = string;
}

- (void)setEnterpriseContact:(NSString *)string {
    self.searchResult.comContact = string;
}

- (void)setCustType:(NSInteger)i {
    self.searchResult.custType = i;
}

- (NSInteger)custType {
    return self.searchResult.custType;
}

- (NSString *)enterPriseName {
    return nil;
}

- (NSString *)enterpriseContact {
    return nil;
}
@end
