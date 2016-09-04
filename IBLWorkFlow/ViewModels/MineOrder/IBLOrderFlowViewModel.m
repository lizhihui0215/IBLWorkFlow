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
    NSMutableArray<IBLSection *> *_dataSource;
}
@property (nonatomic, strong) IBLOrder *order;

@property (nonatomic, strong) IBLFetchOrderFlow *fetchOrderFlow;

@end

@implementation IBLOrderFlowViewModel

- (void)setDataSource:(NSMutableArray<IBLSection *> *)dataSource{
    _dataSource = dataSource;
}

- (NSMutableArray<IBLSection *> *)dataSource{
    return _dataSource;
}

- (instancetype)initWithOrder:(IBLOrder *)order
{
    self = [super init];
    if (self) {
        self.order = order;
        self.fetchOrderFlow = [[IBLFetchOrderFlow alloc] init];
        IBLSection *section = [IBLSection sectionWithInfo:nil
                                                    items:nil];
        self.dataSource = [@[section] mutableCopy];
    }
    return self;
}

- (void)startFetchWithCompleteHandler:(IBLViewModelCompleteHandler)handler{
    [self.fetchOrderFlow fetchOrderFlowWithOrderIdentifier:self.order.identifier
                                           completeHandler:^(NSMutableArray<IBLOrderFlow *> *orderFlows, NSError *error) {
                                               [self sectionAt:0].items = [self sectionItemsWithOrderFlows:orderFlows];
                                               handler(error);
                                           }];
}

- (NSMutableArray<IBLSectionItem *> *)sectionItemsWithOrderFlows:(NSArray<IBLOrderFlow *> *)orderFlows{
    NSMutableArray<IBLSectionItem *> *items = [NSMutableArray array];
    
    for (IBLOrderFlow *orderFlow in orderFlows) {
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:orderFlow selected:NO];
        [items addObject:item];
    }
    
    return items;
}





@end
