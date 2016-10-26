//
//  IBLNetworkServices.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLNetworkServices.h"
static NSString * const IBLAPIBaseURLString = @"http://115.28.0.62:8081/nodeibilling/services/";
@implementation IBLSOAPMethod
- (instancetype)initWithURLString:(NSString *)URLString
                         fileName:(NSString *)fileName
                requestMethodName:(NSString *)requestMethodName
               responseMethodName:(NSString *)responseMethodName {
    self = [super init];
    if (self) {
        self.URLString = URLString;
        self.fileName = fileName;
        self.requestMethodName = requestMethodName;
        self.responseMethodName = responseMethodName;
    }
    
    return self;
}

+ (instancetype)methodWithURLString:(NSString *)URLString
                           fileName:(NSString *)fileName
                  requestMethodName:(NSString *)requestMethodName
                 responseMethodName:(NSString *)responseMethodName {
    return [[self alloc] initWithURLString:URLString
                                  fileName:fileName
                         requestMethodName:requestMethodName
                        responseMethodName:responseMethodName];
}

@end

@interface IBLNetworkServices ()

@property (nonatomic, copy) NSString *URLString;

@end

@implementation IBLNetworkServices

+ (instancetype)networkServicesWithMethod:(IBLSOAPMethod *)method {
    IBLNetworkServices *networkServices = [[IBLNetworkServices alloc] initWithBaseURL:[NSURL URLWithString:IBLAPIBaseURLString]];
    
    networkServices.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    networkServices.requestSerializer = [IBLWebServiceRequestSerializer serializerWithFilename:method.fileName
                                                                                    methodName:method.requestMethodName];
    
    networkServices.responseSerializer = [IBLWebServiceResponseSerializer serializerWithMethodName:method.responseMethodName];
    
    networkServices.URLString = method.URLString;
    
    return networkServices;
}

- (nullable NSURLSessionDataTask *)POST:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    return [self POST:self.URLString
           parameters:parameters
             progress:uploadProgress
              success:success
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                  
                  NSError *err = [NSError errorWithDomain:@""
                                                     code:error.code
                                                 userInfo:@{kExceptionCode : [@(error.code) stringValue],
                                                            kExceptionMessage: description}];
                  failure(task, err);
              }];
}

@end
