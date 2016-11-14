//
//  IBLLoginViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLLoginViewModel.h"
#import "IBLFetchUser.h"

@interface IBLLoginViewModel ()

@property (nonatomic, strong) IBLFetchUser *fetchUser;

@end

@implementation IBLLoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetchUser = [[IBLFetchUser alloc] init];
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(IBLViewModelCompleteHandler)handler {
    
    [self.fetchUser startFetchWithUsername:username
                             password:password
                      completeHandler:^(IBLUser *user, NSError *error) {
                          handler(error);
                      }];
}

- (NSString *)lastUsername {
    return [self.fetchUser lastUser].account;
}

- (NSString *)lastPassword {
    return [self.fetchUser lastUser].password;
}
@end
