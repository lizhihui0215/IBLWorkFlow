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
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"OP_ID" : @"identifier",
                                                       @"NAME" : @"name",
                                                       @"LOGIN_NAME" : @"account",
                                                       @"ROLE_NAME" : @"role",
                                                       @"TELEPHONE" : @"phone"}];
}
@end
