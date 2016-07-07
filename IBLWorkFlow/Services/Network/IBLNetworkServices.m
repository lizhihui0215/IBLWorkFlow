//
//  IBLNetworkServices.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLNetworkServices.h"
static NSString * const IBLAPIBaseURLString = @"https://api.app.net/";

@implementation IBLNetworkServices
+ (instancetype)sharedServices {
    static IBLNetworkServices *_sharedServices = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedServices = [[IBLNetworkServices alloc] initWithBaseURL:[NSURL URLWithString:IBLAPIBaseURLString]];
        
        _sharedServices.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        
        _sharedServices.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        
        _sharedServices.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedServices;
}

@end
