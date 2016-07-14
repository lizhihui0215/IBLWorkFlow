//
//  IBLOrderSearchViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewController.h"
#import "IBLMineOrderViewController.h"

@implementation IBLOrderSearchResult
- (instancetype)initWithStatus:(IBLOrderStatus)status
                       account:(NSString *)account
                      username:(NSString *)username
                         phone:(NSString *)phone
                          type:(NSString *)type
                       bizType:(NSString *)bizType
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
                          type:(NSString *)type
                       bizType:(NSString *)bizType
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

@implementation IBLOrderSearchViewController

@end
