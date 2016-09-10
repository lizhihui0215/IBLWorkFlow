//
//  IBLRenew.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRenew.h"

@interface IBLRenew ()

@property (nonatomic, strong) IBLUserListRepository *userListRepository;

@end

@implementation IBLRenew

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userListRepository = [[IBLUserListRepository alloc] init];
    }
    return self;
}

- (void)renewWithRenewParameters:(IBLRenewParameters *)renewParameters
                 completeHandler:(void (^)(NSString *obj, NSError *))handler{
    [self.userListRepository renewWithRenewParameters:renewParameters
                                      completeHandler:handler];
}
@end
