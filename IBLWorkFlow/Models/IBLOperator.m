//
//  IBLOperator.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOperator.h"

@implementation IBLOperator
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"identifier" : @"OP_ID",
                                                       @"name" : @"NAME",
                                                       @"account" : @"LOGIN_NAME",
                                                       @"role" : @"ROLE_NAME",
                                                       @"phone" : @"TELEPHONE"}];
}
@end
