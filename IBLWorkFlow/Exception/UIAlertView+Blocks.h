//
//  UIAlertView+Blocks.h
//  CMCC
//
//  Created by 李智慧 on 11/10/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCCButtonItem.h"

@interface UIAlertView (Blocks)

- (id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage
   cancelButtonItem:(CMCCButtonItem *)inCancelButtonItem
    otherButtonItem:(CMCCButtonItem *)otherButtonItem otherButtonItems:(va_list)otherButtonItems;

- (NSInteger)addButtonItem:(CMCCButtonItem *)item;

@end
