//
//  IBLWebServiceResponseSerializer.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
FOUNDATION_EXPORT NSString * const kExceptionCode;

FOUNDATION_EXPORT NSString * const kExceptionMessage;

@interface IBLWebServiceResponseSerializer : AFHTTPResponseSerializer
+ (instancetype)serializerWithMethodName:(NSString *)methodName;
@end
