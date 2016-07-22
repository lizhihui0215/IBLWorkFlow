//
//  IBLProductPrice.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLProductPrice.h"

@implementation IBLProductPrice
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"totalFee" : @"totalAmount",
                                                       @"bastTariff" : @"unitPrice",
                                                       @"tariffUnitId" : @"tariffType"}];
}
@end
