//
//  IBLFinishOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFinishOrder.h"
#import "IBLOrder.h"
#import "IBLOrderRepository.h"

@interface IBLFinishOrder ()

@property  (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLFinishOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)finishOrderWith:(IBLOrder *)order
        completeHandler:(void (^)(NSError *))handler {
    [self.orderRepository finishOrderWithId:order.identifier completeHandler:handler];
}
@end
