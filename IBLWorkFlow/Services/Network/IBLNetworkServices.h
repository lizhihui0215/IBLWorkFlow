//
//  IBLNetworkServices.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWebServiceRequestSerializer.h"
#import "IBLWebServiceResponseSerializer.h"

@interface IBLNetworkServices : AFHTTPSessionManager

+ (instancetype)networkServicesWithFileName:(NSString *)fileName
                          requestMethodName:(NSString *)requestMethodName
                         responseMethodName:(NSString *)responseMethodName;

@end
