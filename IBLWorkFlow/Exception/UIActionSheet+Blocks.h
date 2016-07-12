//
//  UIActionSheet+Blocks.h
//  CMCC
//
//  Created by 李智慧 on 11/10/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCCButtonItem.h"

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

- (id)initWithTitle:(NSString *)inTitle
            message:(NSString *)inMessage
   cancelButtonItem:(CMCCButtonItem *)inCancelButtonItem
    otherButtonItem:(CMCCButtonItem *)otherButtonItem
   otherButtonItems:(va_list)otherButtonItems;

- (NSInteger)addButtonItem:(CMCCButtonItem *)item;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (copy, nonatomic) void(^dismissalAction)();

@end
