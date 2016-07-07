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

- (void)startFetchWithCompleteHandler:(void (^)(IBLUser *, NSError *))handler {
    IBLUserRepository *user = [[IBLUserRepository alloc] init];
    
    [user fetchWithCompleteHandler:^(IBLUser *user, NSError *error){
        
    }];
    
}
@end
