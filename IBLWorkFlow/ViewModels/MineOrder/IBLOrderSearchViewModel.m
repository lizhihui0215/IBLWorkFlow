//
//  IBLOrderSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewModel.h"
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

@interface IBLOrderSearchViewModel ()

@property  (nonatomic, strong, readwrite) IBLOrderSearchResult *searchResult;

@end

@implementation IBLOrderSearchViewModel

- (instancetype)initWithSearchResult:(IBLOrderSearchResult *)searchResult {
    self = [super init];
    if (self) {
        self.searchResult = searchResult;
    }

    return self;
}

+ (instancetype)modelWithSearchResult:(IBLOrderSearchResult *)searchResult {
    return [[self alloc] initWithSearchResult:searchResult];
}

@end
