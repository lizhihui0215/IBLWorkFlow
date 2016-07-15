//
//  IBLFetchUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchUser.h"
#import "IBLUserRepository.h"
#import "IBLAppRepository.h"

@implementation IBLFetchUser

- (NSError *)validateWithUsername:(NSString *)username
                         password:(NSString *)password{
    NSError *error = nil;
    
    if ([NSString isNull:username]) {
        error = [NSError errorWithDomain:@""
                                    code:0
                                userInfo:@{kExceptionCode : @"-1",
                                           kExceptionMessage: @"用户名不能为空！"}];
    }
    
    if ([NSString isNull:password]) {
        error = [NSError errorWithDomain:@""
                                    code:0
                                userInfo:@{kExceptionCode : @"-1",
                                           kExceptionMessage: @"密码不能为空！"}];
    }
    
    return error;
}

- (void)startFetchWithUsername:(NSString *)username
                      password:(NSString *)password
               completeHandler:(void (^)(IBLUser *, NSError *))handler {
    IBLUserRepository *user = [[IBLUserRepository alloc] init];
    
    
    NSError *error = [self validateWithUsername:username password:password];
    
    if (error) { handler(nil, error); return; }
    
    [user fetchWithUsername:username
                   password:password
            completeHandler:^(IBLUser *user, NSError *error) {
                
                if (error) { handler(nil, error); return; }
                
                IBLAppRepository *appRepository = [[IBLAppRepository alloc] init];
                [appRepository fetchWithConfigurationWithCompleteHandler:^(IBLAppConfiguration *configuration, NSError *error) {
                    [IBLUserRepository setUser:user];
                    handler(user, error);
                }];                
            }];
}
@end
