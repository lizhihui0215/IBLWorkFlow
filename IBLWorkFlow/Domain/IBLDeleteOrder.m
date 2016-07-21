//
//  IBLMethodOfDeleteOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLDeleteOrder.h"
#import "IBLOrder.h"
#import "IBLOrderRepository.h"

@interface IBLDeleteOrder()

@property  (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLDeleteOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)deleteOrderWithOrder:(IBLOrder *)order
             completeHandler:(void (^)(NSError *))handler {
    [self.orderRepository deleteOrderWithOrderId:order.identifier completeHandler:handler];
}
@end
