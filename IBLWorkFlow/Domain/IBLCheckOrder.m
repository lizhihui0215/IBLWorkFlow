//
//  IBLCheckOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCheckOrder.h"

@interface IBLCheckOrder ()

@property (nonatomic, strong) IBLPayRepository *payRepository;

@end

@implementation IBLCheckOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.payRepository = [[IBLPayRepository alloc] init];
    }
    return self;
}

- (void)checkOrderWithNumber:(NSInteger)orderNumber
             completeHandler:(void (^)(IBLOrderPayStatus, NSError *))handler{
    [self.payRepository checkOrderWithNumber:orderNumber
                             completeHandler:handler];
}

@end
