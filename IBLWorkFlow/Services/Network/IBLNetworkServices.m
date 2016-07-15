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

+ (instancetype)networkServicesWithFileName:(NSString *)fileName
                          requestMethodName:(NSString *)requestMethodName
                         responseMethodName:(NSString *)responseMethodName {
    IBLNetworkServices *networkServices = [[IBLNetworkServices alloc] initWithBaseURL:[NSURL URLWithString:IBLAPIBaseURLString]];
    
    networkServices.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    networkServices.requestSerializer = [IBLWebServiceRequestSerializer serializerWithFilename:fileName methodName:requestMethodName];
    
    networkServices.responseSerializer = [IBLWebServiceResponseSerializer serializerWithMethodName:responseMethodName];
    
    return networkServices;
}

@end
