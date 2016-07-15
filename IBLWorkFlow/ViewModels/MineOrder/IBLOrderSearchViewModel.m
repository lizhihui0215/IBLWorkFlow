//
//  IBLOrderSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewModel.h"
#import "IBLGenerateAppConfiguration.h"

@implementation IBLOrderSearchResult

- (instancetype)initWithStatus:(IBLOrderStatus)status
                       account:(NSString *)account
                      username:(NSString *)username
                         phone:(NSString *)phone
                          type:(IBLWorkOrderType *)type
                       bizType:(IBLWorkOrderBussinessType *)bizType
                     dateRange:(NSString *)dateRange {
    self = [super init];
    if (self) {
        self.account = account;
        self.username = username;
        self.phone = phone;
        self.type = type;
        self.bizType = bizType;
        self.dateRange = dateRange;
        self.status = status;
    }
    
    return self;
}

+ (instancetype)initWithStatus:(IBLOrderStatus)status
             resultWithAccount:(NSString *)account
                      username:(NSString *)username
                         phone:(NSString *)phone
                          type:(IBLWorkOrderType *)type
                       bizType:(IBLWorkOrderBussinessType *)bizType
                     dateRange:(NSString *)dateRange {
    return [[self alloc] initWithStatus:status
                                account:account
                               username:username
                                  phone:phone
                                   type:type
                                bizType:bizType
                              dateRange:dateRange];
}

@end

@interface IBLOrderSearchViewModel ()

@property  (nonatomic, strong, readwrite) IBLOrderSearchResult *searchResult;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@end

@implementation IBLOrderSearchViewModel

- (instancetype)initWithSearchResult:(IBLOrderSearchResult *)searchResult {
    self = [super init];
    if (self) {
        self.searchResult = searchResult;
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

- (void)setStartDate:(NSString *)startDate {
    NSMutableArray *components = [[self.searchResult.dateRange componentsSeparatedByString:@"-"] mutableCopy];
    
    if ([components lastObject]) {
        components[0] = startDate;
        self.searchResult.dateRange = [components componentsJoinedByString:@"-"];
    }else{
        self.searchResult.dateRange = [NSString stringWithFormat:@"%@-",startDate];
    }
}

- (void)setEndDate:(NSString *)endDate {
    NSMutableArray *components = [[self.searchResult.dateRange componentsSeparatedByString:@"-"] mutableCopy];
    
    if ([components lastObject]) {
        components[1] = endDate;
        self.searchResult.dateRange = [components componentsJoinedByString:@"-"];
    }else{
        self.searchResult.dateRange = [NSString stringWithFormat:@"-%@",endDate];
    }
}

- (void)setUserPhone:(NSString *)userPhone {
    self.searchResult.phone = userPhone;
}

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypes {
    return [self.generateAppConfiguration workOrderBizTypes];
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypes {
    return [self.generateAppConfiguration workOrderTypes];
}
@end
