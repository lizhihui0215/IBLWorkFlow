//
//  IBLFieldConfiguration.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFieldConfiguration.h"

@implementation IBLFieldConfiguration
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"open" : @"createAccountFields",
                                                       @"renew" : @"changeProductFields",
                                                       @"change" : @"renewFields"}];
}
@end

