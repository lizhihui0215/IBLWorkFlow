//
//  IBLFetchOrderFlow.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOrderFlow.h"

@interface IBLFetchOrderFlow ()

@property (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLFetchOrderFlow

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)fetchOrderFlowWithOrderIdentifier:(NSInteger)orderIdentifier
           completeHandler:(void (^)(NSMutableArray<IBLOrderFlow *> *, NSError *))handler{
    [self.orderRepository fetchOrderFlowWithIdentifier:orderIdentifier
                                       completaHandler:handler];
    
}

@end
