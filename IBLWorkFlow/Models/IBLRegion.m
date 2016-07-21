//
//  IBLRegion.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRegion.h"

@implementation IBLRegion
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"CHANNEL_NUM" : @"number",
                                                       @"CHANNEL_DESC" : @"desc",
                                                       @"CHANNEL_ADDRESS" : @"address",
                                                       @"NAME" : @"name",
                                                       @"ID" : @"identifier",
                                                       @"PARENTID" : @"parentIdentifier",
                                                       @"CTYPE" : @"type",}];
}
@end
