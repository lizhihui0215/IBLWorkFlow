//
//  IBLNetworkServices.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface IBLNetworkServices : AFHTTPSessionManager

+ (instancetype)sharedServices;

@end
