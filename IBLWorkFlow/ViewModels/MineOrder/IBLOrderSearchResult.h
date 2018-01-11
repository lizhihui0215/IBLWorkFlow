//
// Created by 李智慧 on 7/15/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLOrder.h"

@interface IBLOrderSearchResult : NSObject;

@property (nonatomic, assign) IBLOrderStatus status;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong) IBLWorkOrderType *type;

@property (nonatomic, strong) IBLWorkOrderBussinessType *bizType;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, copy) NSString *dateRange;

@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, copy) NSString *comName;

@property (nonatomic, copy) NSString *comContact;

+ (instancetype)defaultSearchResult;

+ (instancetype)searchResultWithStatus:(IBLOrderStatus)status
                     resultWithAccount:(NSString *)account
                              username:(NSString *)username
                                 phone:(NSString *)phone
                                  type:(IBLWorkOrderType *)type
                               bizType:(IBLWorkOrderBussinessType *)bizType
                             dateRange:(NSString *)dateRange;

@end


