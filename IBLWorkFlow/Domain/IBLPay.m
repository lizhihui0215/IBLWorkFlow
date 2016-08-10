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
         completeHandler:(void (^)(NSArray<id> *, NSError *))handler{
    
    
    [self.payRepository payWithQRPayInfo:QRPayInfo
                         completeHandler:^(NSArray<id> *obj, NSError *error) {
                             
                         }];
    
}

@end
