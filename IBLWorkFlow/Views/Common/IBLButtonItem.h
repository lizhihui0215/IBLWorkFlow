//
//  IBLButtonItem.h
//  CMCC
//
//  Created by 李智慧 on 11/10/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBLButtonItem : NSObject
@property (retain, nonatomic) NSString *label;
@property (nonatomic) NSInteger tag;
@property (copy, nonatomic) void (^action)(IBLButtonItem *item);
+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(IBLButtonItem *item))action;
@end

