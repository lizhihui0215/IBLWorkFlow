//
//  IBLOrderRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderRepository.h"

static NSString const * kOrderStatus = @"orderStatus";

static NSString const * kAccount = @"userAccount";

static NSString const * kUsername = @"userName";

static NSString *const kPhone = @"userPhone";

static NSString *const kType = @"orderType";

static NSString *const kBizType = @"bizType";

static NSString *const kDateRange = @"dateRange";

static NSString *const kStart = @"start";

static NSString *const kPageSize = @"pageSize";

static NSString *const IBLWorkOrderInterface = @"WorkOrderInterface";

static NSString *const IBLWorkOrderSOAPFileName = @"WorkOrder";


static NSString *const kOrderList = @"orderList";

@interface IBLOrderRepository()

@property (nonatomic, strong) IBLSOAPMethod *fetchMineOrderMethod;

@end

@implementation IBLOrderRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:IBLWorkOrderSOAPFileName];
    if (self) {
        self.fetchMineOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfFetchMineOrderList
                                                            responseMethodName:IBLMethodOfOrderMineOrderListResponse];
    }
    return self;
}

- (void)fetchMineOrderListWithFetch:(IBLFetchMineOrderList *)fetch
                              start:(NSInteger)start
                           pageSize:(NSInteger)pageSize
                    completeHandler:(void (^)(NSArray *orderList, NSError *error))handler {
    
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        [parameters addEntriesFromDictionary:@{kOrderStatus : @(fetch.status),
                                               kAccount : fetch.account,
                                               kUsername : fetch.username,
                                               kPhone : fetch.phone,
                                               kType : fetch.type,
                                               kBizType : fetch.bizType,
                                               kDateRange : fetch.dateRange,
                                               kStart : @(start),
                                               kPageSize: @(pageSize)}];
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchMineOrderMethod] POST:IBLWorkOrderInterface
                                                       parameters:parameters
                                                         progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSArray <NSDictionary *> * ordersDictionary = responseObject[kOrderList];
                                                              
                                                              NSMutableArray<IBLOrder *> *orders = [NSMutableArray array];
                                                              for (NSDictionary *orderDictionary in ordersDictionary) {
                                                                  IBLOrder *order = [[IBLOrder alloc] initWithDictionary:orderDictionary error:nil];
                                                                  [orders addObject:order];
                                                              }
                                                              handler(orders, nil);
                                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              handler(nil, error);
                                                          }];
}


@end

@interface IBLFetchMineOrderList ()

@end

@implementation IBLFetchMineOrderList

- (instancetype)initWithDateRange:(NSString *)dateRange
                           status:(IBLOrderStatus)status
                          account:(NSString *)account
                         username:(NSString *)username
                            phone:(NSString *)phone
                             type:(NSString *)type
                          bizType:(NSString *)bizType {
    self = [super init];
    if (self) {
        self.dateRange = dateRange;
        self.status = status;
        self.account = account;
        self.username = username;
        self.phone = phone;
        self.type = type;
        self.bizType = bizType;
    }

    return self;
}

+ (instancetype)listWithDateRange:(NSString *)dateRange
                           status:(IBLOrderStatus)status
                          account:(NSString *)account
                         username:(NSString *)username
                            phone:(NSString *)phone
                             type:(NSString *)type
                          bizType:(NSString *)bizType {
    return [[self alloc] initWithDateRange:dateRange
                                    status:status
                                   account:account
                                  username:username
                                     phone:phone
                                      type:type
                                   bizType:bizType];
}

@end
