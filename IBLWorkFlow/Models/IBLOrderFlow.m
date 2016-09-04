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
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"STATE" : @"state",
                                                       @"OP_NAME" : @"operatorName",
                                                       @"OP_PHONE" : @"operatorPhone",
                                                       @"CREATE_TIME" : @"creatorTime",
                                                       @"FINISH_TIME" : @"finishedTime",
                                                       @"OP_SUGGEST" : @"handleSuggest",
                                                       @"OP_NOTE" : @"handleNote"}];
}

@end
