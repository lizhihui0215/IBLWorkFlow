//
//  IBLFetchOrderRelatedUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOrderRelatedUser.h"

@interface IBLFetchOrderRelatedUser ()

@property (nonatomic, strong) IBLUserListRepository *userListRepository;

@end

@implementation IBLFetchOrderRelatedUser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userListRepository = [[IBLUserListRepository alloc] init];
    }
    return self;
}

- (void)fetchOrderRelatedUserWithID:(NSString *)userID
                            account:(NSString *)account
                    completeHandler:(void (^)(IBLOrderRelateUser *, NSError *))handler{
    [self.userListRepository fetchOrderRelatedUserWithID:userID
                                             account:account
                                     completeHandler:handler];
}


@end
