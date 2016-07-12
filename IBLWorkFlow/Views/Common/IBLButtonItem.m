//
//  IBLButtonItem.m
//  CMCC
//
//  Created by 李智慧 on 11/10/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import "IBLButtonItem.h"

@implementation IBLButtonItem

+(id)item
{
    return [self new];
}

+(id)itemWithLabel:(NSString *)inLabel
{
    IBLButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(IBLButtonItem *item))action
{
  IBLButtonItem *newItem = [self itemWithLabel:inLabel];
  [newItem setAction:action];
  return newItem;
}

@end

