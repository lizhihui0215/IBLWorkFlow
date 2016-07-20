//
// Created by 李智慧 on 7/19/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLTrashOrder.h"
#import "IBLOrder.h"
#import "IBLOrderRepository.h"

@interface IBLTrashOrder ()

@property  (nonatomic, strong) IBLOrderRepository *orderRepository;

@end

@implementation IBLTrashOrder

- (void)trashOrderWith:(IBLOrder *)order completeHandler:(void (^)(NSError *))handler {
    [self.orderRepository trashOrderWithId:order.identifier completeHandler:handler];
}

@end