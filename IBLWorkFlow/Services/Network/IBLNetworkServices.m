//
//  IBLNetworkServices.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLNetworkServices.h"
NSString * IBLAPIBaseURLString = @"";

static NSString * const kLAN = @"com.pccw.networkservices.lan";

static NSString * const kWLAN = @"com.pccw.networkservices.wlan";

static BOOL _isCheckingNetworkStatus = NO;

static __strong AFNetworkReachabilityManager *_reachabilityManager;

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

@property (class, nonatomic, assign) BOOL isCheckingNetworkStatus;

@property (class, nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;

@property (nonatomic, strong) IBLSOAPMethod *method;

@end

@implementation IBLNetworkServices

+ (void)setReachabilityManager:(AFNetworkReachabilityManager *)reachabilityManager{
    _reachabilityManager = reachabilityManager;
}


+ (AFNetworkReachabilityManager *)reachabilityManager{
    return _reachabilityManager;
}

+ (BOOL)isCheckingNetworkStatus{
    return _isCheckingNetworkStatus;
}

+ (void)setIsCheckingNetworkStatus:(BOOL)isCheckingNetworkStatus{
    _isCheckingNetworkStatus = isCheckingNetworkStatus;
}

+ (void)setLANURL:(NSString *)LANURL{
    [[NSUserDefaults standardUserDefaults] setObject:LANURL forKey:kLAN];
}

+ (void)setWLANURL:(NSString *)WLANURL{
    [[NSUserDefaults standardUserDefaults] setObject:WLANURL forKey:kWLAN];
}

+ (NSString *)LANURL{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLAN];
}

+ (NSString *)WLANURL{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kWLAN];
}

+ (void)setupURLWithURLString:(NSString *)URLString completeHandler:(void (^)(void))completeHandler {
    
    if (![NSString isNull:URLString]) {
        if(completeHandler) completeHandler();
        return;
    }
    
    NSString *LANURL =[NSString stringWithFormat:@"http://%@/nodeibilling/services/",IBLNetworkServices.LANURL] ;
    
    NSString *WLANURL = [NSString stringWithFormat:@"http://%@/nodeibilling/services/",IBLNetworkServices.WLANURL];
   
    IBLAPIBaseURLString = [NSString stringWithFormat:@"http://%@/nodeibilling/services/",URLString];
    
    IBLNetworkServices.isCheckingNetworkStatus = YES;
    
    [[AFHTTPSessionManager manager] HEAD:IBLAPIBaseURLString
                              parameters:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task) {
                                     IBLNetworkServices.isCheckingNetworkStatus = NO;
                                     if(completeHandler) completeHandler();
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     if ([IBLAPIBaseURLString isEqualToString:WLANURL])
                                         IBLAPIBaseURLString = LANURL;
                                     IBLNetworkServices.isCheckingNetworkStatus = NO;
                                     if(completeHandler) completeHandler();
                                 }];
}

+ (instancetype)networkServicesWithMethod:(IBLSOAPMethod *)method {
    
    IBLNetworkServices *networkServices = [[IBLNetworkServices alloc] initWithBaseURL:[NSURL URLWithString:IBLAPIBaseURLString]];
    
    networkServices.method = method;
    
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
    if (IBLNetworkServices.isCheckingNetworkStatus) {
        
        NSError *err = [NSError errorWithDomain:@""
                                           code:0
                                       userInfo:@{kExceptionCode : @"0",
                                                  kExceptionMessage: @"检查网络中，请稍后再试..."}];
        failure(nil,err);
        return nil;
    }
    
    return [self POST:self.URLString
           parameters:parameters
             progress:uploadProgress
              success:success
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  if (error.code == NSURLErrorCannotConnectToHost){
                      [self switchWithParameters:parameters
                                        progress:uploadProgress
                                         success:success
                                         failure:failure];
                      return ;
                  }
                  
                  NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                  
                  NSError *err = [NSError errorWithDomain:@""
                                                     code:error.code
                                                 userInfo:@{kExceptionCode : [@(error.code) stringValue],
                                                            kExceptionMessage: description}];
                  failure(task, err);
              }];
}

- (void)switchWithParameters:(nullable id)parameters
                    progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                     success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    
    NSString *LANURL =[NSString stringWithFormat:@"http://%@/nodeibilling/services/",IBLNetworkServices.LANURL] ;
    
    NSString *WLANURL = [NSString stringWithFormat:@"http://%@/nodeibilling/services/",IBLNetworkServices.WLANURL];
    
    NSString *previousURL = IBLAPIBaseURLString;
    
    if ([IBLAPIBaseURLString isEqualToString:LANURL])
        IBLAPIBaseURLString = WLANURL;
    else
        IBLAPIBaseURLString = LANURL;
    
    [[IBLNetworkServices networkServicesWithMethod:self.method] POST:self.URLString
                                                          parameters:parameters
                                                            progress:uploadProgress
                                                             success:success
                                                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                 IBLAPIBaseURLString = previousURL;
                                                                 NSString *description = error.userInfo[NSLocalizedDescriptionKey];
                                                                 
                                                                 NSError *err = [NSError errorWithDomain:@""
                                                                                                    code:error.code
                                                                                                userInfo:@{kExceptionCode : [@(error.code) stringValue],
                                                                                                           kExceptionMessage: description}];
                                                                 failure(task, err);
                                                             }];
}

@end
