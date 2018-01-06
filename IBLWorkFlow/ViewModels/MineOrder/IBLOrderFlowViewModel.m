//
//  IBLOrderFlowViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderFlowViewModel.h"

@interface IBLOrderFlowViewModel()
{
    NSMutableArray<PCCWSection *> *_dataSource;
}
@property (nonatomic, strong) IBLOrder *order;

@property (nonatomic, strong) IBLFetchOrderFlow *fetchOrderFlow;

@end

@implementation IBLOrderFlowViewModel

- (void)setDataSource:(NSMutableArray<PCCWSection *> *)dataSource{
    _dataSource = dataSource;
}

- (NSMutableArray<PCCWSection *> *)dataSource{
    return _dataSource;
}

- (instancetype)initWithOrder:(IBLOrder *)order
{
    self = [super init];
    if (self) {
        self.order = order;
        self.fetchOrderFlow = [[IBLFetchOrderFlow alloc] init];
        PCCWSection *section = [PCCWSection sectionWithInfo:nil
                                                    items:nil];
        self.dataSource = [@[section] mutableCopy];
    }
    return self;
}

- (void)startFetchWithCompleteHandler:(PCCWViewModelCompleteHandler)handler{
    [self.fetchOrderFlow fetchOrderFlowWithOrderIdentifier:self.order.identifier
                                           completeHandler:^(NSMutableArray<IBLOrderFlow *> *orderFlows, NSError *error) {
                                               [self sectionAt:0].items = [self sectionItemsWithOrderFlows:orderFlows];
                                               handler(error);
                                           }];
}

- (NSMutableArray<PCCWSectionItem *> *)sectionItemsWithOrderFlows:(NSArray<IBLOrderFlow *> *)orderFlows{
    NSMutableArray<PCCWSectionItem *> *items = [NSMutableArray array];
    
    for (IBLOrderFlow *orderFlow in orderFlows) {
        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:orderFlow selected:NO];
        [items addObject:item];
    }
    
    return items;
}

- (IBLOrderFlow *)orderFlowAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSectionItem *item = [self sectionItemAtIndexPath:indexPath];
    IBLOrderFlow *orderFlow = item.info;
    return orderFlow;
}

- (NSString *)orderStatusNameWithStatus:(IBLOrderStatus)status{
    NSDictionary *workOrderStatus = @{@(IBLOrderStatusUnsend) : @"[未派单]",
                                      @(IBLOrderStatusSended) : @"[未处理]",
//                                      @(IBLOrderStatusForwarding) : @"[转发中]",
                                      @(IBLOrderStatusHandling) : @"[处理中]",
                                      @(IBLOrderStatusInvalid) : @"[作废]",
                                      @(IBLOrderStatusFinished) : @"[完成]",
                                      @(IBLOrderStatusFeedback) : @"[反馈中]"};
    return workOrderStatus[@(status)];
}

- (NSString *)statusAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrderFlow *orderFlow = [self orderFlowAtIndexPath:indexPath];
    
    return [self orderStatusNameWithStatus:orderFlow.state];
}

- (NSString *)operatorNameAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrderFlow *orderFlow = [self orderFlowAtIndexPath:indexPath];
    
    return orderFlow.operatorName;
}

- (NSString *)suggestAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrderFlow *orderFlow = [self orderFlowAtIndexPath:indexPath];

    return orderFlow.handleSuggest;
}

- (NSString *)handleDateAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrderFlow *orderFlow = [self orderFlowAtIndexPath:indexPath];

    return orderFlow.creatorTime;
}
@end
