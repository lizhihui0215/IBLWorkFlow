//
//  IBLCreateAccount.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/27/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccount.h"
#import "IBLUserListRepository.h"

@interface IBLCreateAccount ()

@property (nonatomic, strong) IBLUserListRepository *userListRepository;

@end

@implementation IBLCreateAccount

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userListRepository = [[IBLUserListRepository alloc] init];
    }
    return self;
}

- (void)createAccountWithInfo:(IBLCreateAccountInfo *)createAccountInfo
              completeHandler:(void (^)(id, NSError *))handler{
    [self.userListRepository createAccountWithInfo:createAccountInfo
                                   completeHandler:handler];
}

@end
