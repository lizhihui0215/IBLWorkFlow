//
//  IBLWorkOrderType.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWorkOrderType.h"

@implementation IBLWorkOrderType
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"NAME" : @"name",
                                                       @"VALUE" : @"status"}];
}
@end
