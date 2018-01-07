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
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"phone" : @"CHANNEL_NUM",
                                                                  @"desc" : @"CHANNEL_DESC",
                                                                  @"address" : @"CHANNEL_ADDRESS",
                                                                  @"name" : @"NAME",
                                                                  @"identifier" : @"ID",
                                                                  @"parentIdentifier" : @"PARENTID",
                                                                  @"type" : @"CTYPE",}];
}
@end
