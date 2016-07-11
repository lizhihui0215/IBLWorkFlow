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

@end

@implementation IBLLoginViewModel

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(IBLViewModelCompleteHandler)handler {
    
    IBLFetchUser *fetchUser = [[IBLFetchUser alloc] init];
    
    if(![fetchUser validateWithHandler:handler]) return;
    
    [fetchUser startFetchWithUsername:username
                             password:password
                      completeHandler:^(IBLUser *user, NSError *error) {
                          
                      }];
}
@end
