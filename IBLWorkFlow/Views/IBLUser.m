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

// 优惠金额
- (BOOL)isHiddenPreferential {
//    preferentialPayment_cfield
    for (IBLPremission *premission in self.permissions) {
        if ([[premission.key uppercaseString] isEqualToString:@"PREFERENTIALPAYMENT_CFIELD"]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isHiddenExtraMonthLength {
    //    extraMonthLength_cfield
    for (IBLPremission *premission in self.permissions) {
        if ([[premission.key uppercaseString] isEqualToString:@"EXTRAMONTHLENGTH_CFIELD"]) {
            return NO;
        }
    }
    return YES;
}




+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"identifier" : @"allocId",
                                                                  @"permissions" : @"resourceList"}];
}

@end
