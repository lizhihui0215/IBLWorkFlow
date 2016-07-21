//
//  IBLSendOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSendOrder.h"
#import "IBLOrderRepository.h"
#import "IBLOperator.h"

@interface IBLSendOrder ()

@property  (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLSendOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.orderRepository = [[IBLOrderRepository alloc] init];
    }
    return self;
}

- (void)sendOrderWith:(IBLOrder *)order
             operator:(IBLOperator *)operator
              content:(NSString *)content
      completeHandler:(void (^)(NSError *))handler {
    [self.orderRepository sendOrderWithId:order.identifier
                                  operatorId:operator.identifier
                                     content:content
                             completeHandler:handler];
}
@end
