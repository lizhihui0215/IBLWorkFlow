//
//  IBLNetworkServices.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLNetworkServices.h"
static NSString * const IBLAPIBaseURLString = @"http://115.28.0.62:8081/nodeibilling/services/";

@implementation IBLNetworkServices
+ (instancetype)sharedServices {
    static IBLNetworkServices *_sharedServices = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedServices = [[IBLNetworkServices alloc] initWithBaseURL:[NSURL URLWithString:IBLAPIBaseURLString]];
                
        _sharedServices.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedServices;
}


@end
