//
//  IBLExchangeProduct.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLExchangeProduct.h"

@interface IBLExchangeProduct ()

@property (nonatomic, strong) IBLUserListRepository *userListRepository;

@end

@implementation IBLExchangeProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userListRepository = [[IBLUserListRepository alloc] init];
    }
    return self;
}

- (void)exchangeProductWithParameters:(IBLExchangeProductParameters *)exchangeProductParameters
                      completeHandler:(void (^)(NSString *obj, NSError *))handler{
    [self.userListRepository exchangeProductWithParameters:exchangeProductParameters
                                           completeHandler:handler];
}

@end
