//
//  IBLNetworkServices.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWebServiceRequestSerializer.h"
#import "IBLWebServiceResponseSerializer.h"

NS_ASSUME_NONNULL_BEGIN
@interface IBLSOAPMethod : NSObject

@property (nonatomic, copy) NSString *URLString;

@property (nonatomic, copy) NSString *requestMethodName;

@property (nonatomic, copy) NSString *responseMethodName;

@property (nonatomic, copy) NSString *fileName;

- (instancetype)initWithURLString:(NSString *)URLString
                         fileName:(NSString *)fileName
                requestMethodName:(NSString *)requestMethodName
               responseMethodName:(NSString *)responseMethodName;


+ (instancetype)methodWithURLString:(NSString *)URLString
                           fileName:(NSString *)fileName
                  requestMethodName:(NSString *)requestMethodName
                 responseMethodName:(NSString *)responseMethodName;

@end

@interface IBLNetworkServices : AFHTTPSessionManager
+ (instancetype)networkServicesWithMethod:(IBLSOAPMethod *)method;

- (nullable NSURLSessionDataTask *)POST:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
