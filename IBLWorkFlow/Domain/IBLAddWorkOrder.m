//
//  IBLAddWorkOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/3/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAddWorkOrder.h"

@interface IBLAddWorkOrder ()

@property (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLAddWorkOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)addWorkOrderWith:(IBLAddWorkOrderInfo *)addWorkOrderInfo
         completeHandler:(void(^)(NSString *orderId, NSError *error)) completeHandler{
    [self.orderRepository addWorkOrdeWith:addWorkOrderInfo
                          completeHandler:completeHandler];
}

@end
