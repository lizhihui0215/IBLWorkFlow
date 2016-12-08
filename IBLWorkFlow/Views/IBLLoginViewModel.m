//
//  IBLLoginViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLLoginViewModel.h"
#import "IBLFetchUser.h"
#import "IBLException.h"

@interface IBLLoginViewModel ()

@property (nonatomic, strong) IBLFetchUser *fetchUser;

@property(nonatomic, copy) NSString *LAN;

@property(nonatomic, copy) NSString *WLAN;

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

    if ([NSString isNull:self.LAN] && [NSString isNull:self.WLAN]){
        handler([NSError errorWithDomain:@""
                                    code:0
                                userInfo:@{kExceptionCode : @"-1",
                                           kExceptionMessage: @"请输入服务器地址！"}]);
        return;
    }
    
    [self.fetchUser setupLAN:self.LAN WLAN:self.WLAN];

    
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

- (NSString *)lastLAN {
    return [self.fetchUser lastLAN];
}

- (NSString *)lastWLAN {
    return [self.fetchUser lastWLAN];
}
@end
