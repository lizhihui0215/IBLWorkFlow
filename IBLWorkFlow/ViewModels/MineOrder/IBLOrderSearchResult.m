//
// Created by 李智慧 on 7/15/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchResult.h"

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

+ (instancetype)defaultSearchResult{
    
    IBLWorkOrderType *type = [[IBLWorkOrderType alloc] init];
    type.name = @"";
    type.status = IBLWorkOrderStatusUnknow;
    IBLWorkOrderBussinessType *bizType = [[IBLWorkOrderBussinessType alloc] init];
    bizType.name = @"";
    bizType.status = IBLWorkOrderBizStatusUnknow;

    return [IBLOrderSearchResult searchResultWithStatus:IBLOrderStatusUnsend
                                      resultWithAccount:@""
                                               username:@""
                                                  phone:@""
                                                   type:type
                                                bizType:bizType
                                              dateRange:@""];
}

+ (instancetype)searchResultWithStatus:(IBLOrderStatus)status
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