//
//  IBLOrderSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewModel.h"
#import "IBLGenerateAppConfiguration.h"

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
    
    if (![NSString isNull:[components lastObject]]) {
        components[0] = startDate;
        self.searchResult.dateRange = [components componentsJoinedByString:@"-"];
    }else{
        self.searchResult.dateRange = [NSString stringWithFormat:@"%@-",startDate];
    }
}

- (void)setEndDate:(NSString *)endDate {
    NSMutableArray *components = [[self.searchResult.dateRange componentsSeparatedByString:@"-"] mutableCopy];
    
    if (![NSString isNull:[components lastObject]]) {
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

- (NSString *)startDate {
    NSArray *dates = [self.searchResult.dateRange componentsSeparatedByString:@"-"];
    
    return dates.firstObject;
}

- (NSString *)endDate {
    NSArray *dates = [self.searchResult.dateRange componentsSeparatedByString:@"-"];
    return dates.lastObject;
}
@end
