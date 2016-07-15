//
//  IBLMineOrderViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLMineOrderViewModel.h"
#import "IBLOrderSearchViewModel.h"

@interface IBLMineOrderViewModel ()

@property (nonatomic, strong) IBLFetchOrder *fetchOrder;

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, IBLOrderSearchResult *> *searchResults;

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
             @(4) : @(IBLOrderStatusInvalid),
             @(5) : @(IBLOrderStatusFinished),
             @(6) : @(IBLOrderStatusFeedback)};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetchOrder = [[IBLFetchOrder alloc] init];
        self.searchResults = [@{@(0) : [IBLOrderSearchResult defaultSearchResult],
                                @(1) : [IBLOrderSearchResult defaultSearchResult] ,
                                @(2) : [IBLOrderSearchResult defaultSearchResult],
                                @(3) : [IBLOrderSearchResult defaultSearchResult],
                                @(4) : [IBLOrderSearchResult defaultSearchResult],
                                @(5) : [IBLOrderSearchResult defaultSearchResult],
                                @(6) : [IBLOrderSearchResult defaultSearchResult]} mutableCopy];
        
    }
    return self;
}

- (IBLFetchMineOrderList *)fetchMineOrderListWithIndex:(NSInteger)index{
    IBLOrderStatus status = [self statusWithIndex:index];
    
    IBLOrderSearchResult *fetchResut = [self searchResultWithIndex:index];
    
    return [IBLFetchMineOrderList listWithDateRange:fetchResut.dateRange
                                             status:status
                                            account:fetchResut.account
                                           username:fetchResut.username
                                              phone:fetchResut.phone
                                               type:fetchResut.type.status
                                            bizType:fetchResut.bizType.status];
    
}

- (void)fetchMineOrderListWithIndex:(NSInteger)index
                          isRefresh:(BOOL)isRefresh
                    completeHandler:(IBLViewModelCompleteHandler)handler {
    IBLFetchMineOrderList *fetch = [self fetchMineOrderListWithIndex:index];

    [self.fetchOrder fetchMineOrderListWithIsRefresh:isRefresh
                                               fetch:fetch
                                     completeHandler:^(NSArray *orderList, NSError *error) {
                                         
                                     }];
}

- (void)setSearchResult:(IBLOrderSearchResult *)searchResult
                  index:(NSInteger)index {
    self.searchResults[@(index)] = searchResult;
}

- (IBLOrderSearchResult *)searchResultWithIndex:(NSInteger)index {
    return self.searchResults[@(index)];
}
@end
