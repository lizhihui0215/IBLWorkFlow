//
//  IBLMineOrderViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLMineOrderViewModel.h"
#import "IBLOrderSearchViewModel.h"
#import "IBLGenerateAppConfiguration.h"

@interface IBLMineOrderViewModel ()
{
    NSMutableArray *_dataSource;
}

@property (nonatomic, strong) IBLFetchOrder *fetchOrder;

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, IBLOrderSearchResult *> *searchResults;

@end

@implementation IBLMineOrderViewModel

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
}

- (NSMutableArray *)dataSource{
    return _dataSource;
}

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
        IBLSection *section1 = [IBLSection sectionWithInfo:nil items:nil];
        IBLSection *section2 = [IBLSection sectionWithInfo:nil items:nil];
        IBLSection *section3 = [IBLSection sectionWithInfo:nil items:nil];
        IBLSection *section4 = [IBLSection sectionWithInfo:nil items:nil];
        IBLSection *section5 = [IBLSection sectionWithInfo:nil items:nil];

        self.dataSource = [@[section1, section2, section3, section4, section5] mutableCopy];

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
                                     completeHandler:^(NSMutableArray<IBLOrder *> *orderList, NSError *error) {
                                         [self setDataSourceWithIndex:index isRefresh:isRefresh orderList:orderList];
                                         handler(error);
                                     }];
}

- (void)setDataSourceWithIndex:(NSInteger)index
                     isRefresh:(BOOL)refresh
                     orderList:(NSMutableArray<IBLOrder *> *)orderList {
    IBLSection *section = self.dataSource[index];

    NSMutableArray<IBLSectionItem *> *items = [self itemsWithOrders:orderList];

    if (refresh) section.items = items; else [section.items addObjectsFromArray:items];
}

- (NSMutableArray<IBLSectionItem *> *)itemsWithOrders:(NSMutableArray<IBLOrder *> *)orders {
    NSMutableArray<IBLSectionItem *> *items = [NSMutableArray array];

    for (IBLOrder *order in orders) {
        order.actions = [self orderActionsWithStatus:order.status];
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:order selected:NO];
        [items addObject:item];
    }

    return items;
}

- (NSMutableArray<NSNumber *> *)orderActionsWithStatus:(IBLOrderStatus)status {
    
    
    return nil;
}

- (void)setSearchResult:(IBLOrderSearchResult *)searchResult
                  index:(NSInteger)index {
    self.searchResults[@(index)] = searchResult;
}

- (IBLOrderSearchResult *)searchResultWithIndex:(NSInteger)index {
    return self.searchResults[@(index)];
}

- (IBLOrder *)orderAtIndexPath:(NSIndexPath *)indexPath{
    IBLSection *section = [self sectionAt:indexPath.section];
    IBLSectionItem *sectionItem = section.items[indexPath.row];
    return sectionItem.info;
}

- (NSString *)workOrderBizTypeNameWithStatus:(IBLWorkOrderBizStatus)status{
    NSDictionary *workOrderBizTypes = @{@(IBLWorkOrderBizStatusUnknow) : @"[ 未知 ]",
                                        @(IBLWorkOrderBizStatusRepair) : @"[ 报修 ]",
                                        @(IBLWorkOrderBizStatusInstall) : @"[ 报装 ]",
                                        @(IBLWorkOrderBizStatusStop) : @"[ 停机修复 ]",
                                        @(IBLWorkOrderBizStatusReturn) : @"[ 退网 ]",
                                        @(IBLWorkOrderBizStatusMove) : @"[ 移网 ]",
                                        @(IBLWorkOrderBizStatusHandleMalfunction) : @"[ 故障处理 ]",
                                        @(IBLWorkOrderBizStatusHandleComplaints) : @"[ 投诉处理 ]",
                                        @(IBLWorkOrderBizStatusHandleAdvisory) : @"[ 咨询处理 ]",
                                        @(IBLWorkOrderBizStatusHandleReply) : @"[ 回访处理 ]",
                                        @(IBLWorkOrderBizStatusElectrical) : @"[ 接电 ]",
                                        @(IBLWorkOrderBizStatusAddBox) : @"[ 加箱 ]",
                                        @(IBLWorkOrderBizStatusChangeBox) : @"[ 改箱 ]",
                                        @(IBLWorkOrderBizStatusAddLock) : @"[ 加锁 ]",
                                        @(IBLWorkOrderBizStatusFlyLine) : @"[ 飞线 ]",
                                        @(IBLWorkOrderBizStatusSplice) : @"[ 熔纤 ]",
                                        @(IBLWorkOrderBizStatusThroughCable) : @"[ 穿光缆 ]",
                                        @(IBLWorkOrderBizStatusLightBarrier) : @"[ 光不通 ]",
                                        @(IBLWorkOrderBizStatusLineBarrier) : @"[ 线不通穿线 ]",
                                        @(IBLWorkOrderBizStatusCableBreak) : @"[ 光缆断 ]",
                                        @(IBLWorkOrderBizStatusOther) : @"[ 其他 ]"};

    return workOrderBizTypes[@(status)];
}

- (NSString *)workOrderTypAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return [self workOrderBizTypeNameWithStatus:order.bizType];
}

- (NSString *)usernameAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return order.username;
}

- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return order.lastModifyTime;
}

- (IBLPriorityStatus)orderPriorityAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return order.priority;
}

- (NSArray *)orderOperationTitlesAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    order.actions;

    return nil;
}

- (IBLOrderAction)actionAtIndex:(NSInteger)index {
    return IBLOrderActionHandling;
}
@end
