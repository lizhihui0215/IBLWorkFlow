//
//  UIDevice+IBLExtension.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "UIDevice+IBLExtension.h"
#import <Security/Security.h>

@implementation UIDevice (IBLExtension)

+ (NSString *)UUID{
    NSString *currentDeviceUUIDStr = [SSKeychain passwordForService:@" " account:@"uuid"];
    
    if ([NSString isNull:currentDeviceUUIDStr]) {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@" " account:@"uuid"];
    }
    
    return currentDeviceUUIDStr;
}
@end
