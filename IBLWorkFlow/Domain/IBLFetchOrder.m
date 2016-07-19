//
//  IBLFetchOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOrder.h"
#import "IBLOperator.h"

@interface IBLFetchOrder ()

@property (nonatomic, strong) IBLOrderRepository *orderRepository;

@property (nonatomic, strong) NSMutableDictionary *startDictionary;

@end

@implementation IBLFetchOrder

- (NSInteger)startWithStatus:(NSInteger)status{
   return  [self.startDictionary[@(status)] integerValue];
}

- (void)setStart:(NSInteger)start status:(NSInteger)status{
    self.startDictionary[@(status)] = @(start);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
        self.startDictionary = [@{@(IBLOrderStatusUnsend) : @(0),
                                  @(IBLOrderStatusSended) : @(0),
                                  @(IBLOrderStatusHandling) : @(0),
                                  @(IBLOrderStatusForwarding) : @(0),
                                  @(IBLOrderStatusInvalid) : @(0),
                                  @(IBLOrderStatusFinished) : @(0),
                                  @(IBLOrderStatusFeedback) : @(0)} mutableCopy];
    }
    return self;
}

- (BOOL)validateWithFetch:(IBLFetchOrderList *)fetch{
    if (!fetch.dateRange) fetch.dateRange = @"";
    
    if (!fetch.username) fetch.username = @"";
    
    if (!fetch.account) fetch.account = @"";
    
    if (!fetch.phone) fetch.phone = @"";
    
    return YES;
}

- (void)fetchOrderListWithIsRefresh:(BOOL)isRefresh
                              fetch:(IBLFetchOrderList *)fetch
                    completeHandler:(void (^)(NSMutableArray<IBLOrder *> *, NSError *error))handler{
    [self validateWithFetch:fetch];
    
    __block NSInteger start = [self startWithStatus:fetch.status];
    
    if (isRefresh) start = 0; else start += 1;
    
    [self.orderRepository fetchMineOrderListWithFetch:fetch
                                                start:start
                                             pageSize:20
                                      completeHandler:^(NSMutableArray<IBLOrder *> *orderList, NSError *error) {
                                          if(!error) [self setStart:start status:fetch.status];
                                          handler(orderList,error);
                                      }];
}


@end
