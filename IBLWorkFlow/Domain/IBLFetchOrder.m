//
//  IBLFetchOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOrder.h"

@interface IBLFetchOrder ()

@property (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLFetchOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch
                        completeHandler:(void (^)(NSArray *orderList, NSError *error))handler{
    
    [self.orderRepository fetchMineOrderListWithIsRefresh:isRefresh
                                                    fetch:fetch
                                          completeHandler:^(NSArray *orderList, NSError *error) {
                                              
                                          }];
}

@end
