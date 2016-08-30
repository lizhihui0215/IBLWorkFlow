//
//  IBLFetchOrderDetail.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOrderDetail.h"

@interface IBLFetchOrderDetail ()

@property (nonatomic, strong) IBLPayRepository *payRepository;

@end

@implementation IBLFetchOrderDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.payRepository = [[IBLPayRepository alloc] init];
    }
    return self;
}

- (void)fetchOrderDetailWithOrderNumber:(NSString *)orderNumber
                        completeHandler:(void (^)(IBLOrderDetail *, NSError *))handler{
    [self.payRepository fetchOrderDetailWithOrderNumber:orderNumber
                                        completeHandler:handler];

}

@end
