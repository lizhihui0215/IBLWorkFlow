//
//  IBLWebServiceRequestSerializer.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface IBLWebServiceRequestSerializer : AFHTTPRequestSerializer

+ (instancetype)serializerWithFilename:(NSString *)fileName methodName:(NSString *)methodName;

@end
