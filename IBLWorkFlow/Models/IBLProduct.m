//
// Created by 李智慧 on 7/21/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLProduct.h"


@implementation IBLProduct
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"OFFER_ID" : @"identifier",
                                                       @"OFFER_NAME" : @"name"}];
}
@end
