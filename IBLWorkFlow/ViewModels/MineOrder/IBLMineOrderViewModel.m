//
//  IBLMineOrderViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLMineOrderViewModel.h"

@interface IBLMineOrderViewModel ()

@property (nonatomic, strong) IBLFetchOrder *fetchOrder;

@end

@implementation IBLMineOrderViewModel

- (IBLOrderStatus)statusWithIndex:(NSInteger)index{
    return [[self statusDictionary][@(index)] integerValue];
}

- (NSDictionary *)statusDictionary{
    return @{@(0) : @(IBLOrderStatusUnsend),
             @(1) : @(IBLOrderStatusSended) ,
             @(2) : @(IBLOrderStatusHandling),
             @(3) : @(IBLOrderStatusForwarding),
             @(4) :@(IBLOrderStatusInvalid),
             @(5) :@(IBLOrderStatusFinished),
             @(6) :@(IBLOrderStatusFeedback)};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetchOrder = [[IBLFetchOrder alloc] init];
    }
    return self;
}

- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch
                        completeHandler:(IBLViewModelCompleteHandler)handler{
    
    [self.fetchOrder fetchMineOrderListWithIsRefresh:isRefresh
                                               fetch:fetch
                                     completeHandler:^(NSArray *orderList, NSError *error) {
                                         
                                     }];
}
@end
