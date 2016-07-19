//
//  IBLForwardOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLForwardOrder.h"
#import "IBLOrderRepository.h"
#import "IBLOperator.h"

@interface IBLForwardOrder ()

@property (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLForwardOrder


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)forwardOrderWith:(IBLOrder *)order
                operator:(IBLOperator *)operator
         completeHandler:(void (^)(NSError *))handler {
    [self.orderRepository forwardOrderWithId:order.identifier operatorId:operator.identifier content:nil completeHandler:^(NSError *error) {

    }];
    
}
@end
