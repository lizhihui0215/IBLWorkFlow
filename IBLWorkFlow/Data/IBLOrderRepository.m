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

static NSString const * kPhone = @"userPhone";

static NSString const * kType = @"orderType";

static NSString const * kBizType = @"bizType";

static NSString const * kDateRange = @"dateRange";

static NSString const * kStart = @"start";

static NSString const * kPageSize = @"pageSize";

static NSString *const IBLWorkOrderInterface = @"WorkOrderInterface";

static NSString *const IBLWorkOrderSOAPFileName = @"WorkOrder";

static NSString *const IBLMethodOfFetchMineOrderList = @"getMyOrderList";

static NSString *const IBLMethodOfOrderMineOrderListResponse = @"getMyOrderListResponse";

@interface IBLOrderRepository()

@end

@implementation IBLOrderRepository

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkServices.requestSerializer = [IBLWebServiceRequestSerializer serializerWithFilename:IBLWorkOrderSOAPFileName
                                                                                             methodName:IBLMethodOfFetchMineOrderList];
        
        self.networkServices.responseSerializer = [IBLWebServiceResponseSerializer serializerWithMethodName:IBLMethodOfOrderMineOrderListResponse];
    }
    return self;
}

- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        [parameters addEntriesFromDictionary:@{kOrderStatus : fetch.status,
                                               kAccount : fetch.account,
                                               kUsername : fetch.username,
                                               kPhone : fetch.phone,
                                               kType : fetch.type,
                                               kBizType : fetch.bizType,
                                               kDateRange : fetch.dateRange,
                                               kStart : @"",
                                               kPageSize: @""}];
        return parameters;
    }];
    
    [self.networkServices POST:IBLWorkOrderInterface
                    parameters:parameters
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           
                       }];
}


@end

@interface IBLFetchMineOrderList ()

@end

@implementation IBLFetchMineOrderList

- (instancetype)initWithDateRange:(NSString *)dateRange
                           status:(NSString *)status
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
                           status:(NSString *)status
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
