//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductViewModel.h"
#import "IBLRelateUser.h"


@implementation IBLExchangeProductViewModel

- (instancetype)initWithUser:(IBLRelateUser *)user {
    self = [super init];
    if (self) {
        _user = user;
    }

    return self;
}

+ (instancetype)modelWithUser:(IBLRelateUser *)user {
    return [[self alloc] initWithUser:user];
}


@end