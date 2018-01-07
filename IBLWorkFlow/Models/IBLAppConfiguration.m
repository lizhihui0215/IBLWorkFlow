//
//  IBLAppConfiguration.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAppConfiguration.h"

@implementation IBLAppConfiguration
+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"workOrderTypes" : @"orderTypeList",
                                                       @"workOrderBizTypes" : @"bizTypeList",
                                                       @"orderURL" : @"orderUrl",
                                                       @"custType" : @"defaultCustType"}];
}
@end


@implementation IBLGenarate

@end
