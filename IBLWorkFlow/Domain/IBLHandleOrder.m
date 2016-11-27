//
//  IBLHandleOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLHandleOrder.h"
#import "IBLOrderRepository.h"



@interface IBLHandleOrder ()

@property  (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLHandleOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}


- (void)handleOrderWithOrder:(IBLOrder *)order
                  markHandle:(NSString *)markHandle
                      servId:(NSString *)servId
                     content:(NSString *)content
             completeHandler:(void (^)(NSError *))handler {
    [self.orderRepository handleOrderWithId:order.identifier
                                     servId:servId
                                 markHandle:markHandle
                                    content:content
                            completeHandler:handler];
}
@end
