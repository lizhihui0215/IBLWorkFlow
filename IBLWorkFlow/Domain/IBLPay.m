//
//  IBLPay.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLPay.h"

@interface IBLPay ()

@property (nonatomic, strong) IBLPayRepository *payRepository;

@end

@implementation IBLPay

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.payRepository = [[IBLPayRepository alloc] init];
    }
    return self;
}

- (void)payWithQRPayInfo:(IBLQRPayInfo *)QRPayInfo
         completeHandler:(void (^)(NSString *, NSError *))handler{
    [self.payRepository payWithQRPayInfo:QRPayInfo
                         completeHandler:^(NSString *obj, NSError *error) {
                             handler(obj,error);
                         }];
}

@end
