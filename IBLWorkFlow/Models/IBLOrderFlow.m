//
//  IBLOrderFlow.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderFlow.h"

@implementation IBLOrderFlow

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"state" : @"STATE",
                                                                  @"operatorName" : @"OP_NAME",
                                                                  @"operatorPhone" : @"OP_PHONE",
                                                                  @"creatorTime" : @"CREATE_TIME",
                                                                  @"finishedTime" : @"FINISH_TIME",
                                                                  @"handleSuggest" : @"OP_SUGGEST",
                                                                  @"handleNote" : @"OP_NOTE"}];
}

@end
