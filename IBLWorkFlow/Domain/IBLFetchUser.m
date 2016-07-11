//
//  IBLFetchUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchUser.h"
#import "IBLUserRepository.h"

@implementation IBLFetchUser

- (BOOL)validateWithHandler:(void (^)(NSError *))handler{
    
    return YES;
}

- (void)startFetchWithUsername:(NSString *)username
                      password:(NSString *)password
               completeHandler:(void (^)(IBLUser *, NSError *))handler {
    IBLUserRepository *user = [[IBLUserRepository alloc] init];
    
    [user fetchWithUsername:username
                   password:password
            completeHandler:^(IBLUser *user, NSError *error) {
                
            }];
}
@end
