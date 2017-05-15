//
//  IBLPremission.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLPremission.h"

@implementation IBLPremission

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"resKey" : @"key",
                                                       @"resName" : @"name",
                                                       @"resDesc" : @"des",
                                                       @"resType" : @"type",
                                                       }];
}

@end
