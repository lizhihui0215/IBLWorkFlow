//
//  IBLUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUser.h"

@implementation IBLUser

- (BOOL)isOnlinePay{
    for (IBLPremission *premission in self.permissions) {
        if([premission.key isEqualToString:@"USE_ONLINE_PAY"]){
            return YES;
        }
    }
    
    return NO;
}

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"allocId" : @"identifier",
                                                       @"resourceList" : @"permissions"}];
}

@end
