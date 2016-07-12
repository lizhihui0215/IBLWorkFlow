//
//  UIAlertView+Blocks.m
//  CMCC
//
//  Created by 李智慧 on 11/10/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static NSString *CMCC_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
@implementation UIAlertView (Blocks)
#pragma clang diagnostic pop

- (id)initWithTitle:(NSString *)inTitle
            message:(NSString *)inMessage
   cancelButtonItem:(CMCCButtonItem *)inCancelButtonItem
    otherButtonItem:(CMCCButtonItem *)otherButtonItem
   otherButtonItems:(va_list)otherButtonItems {
    if((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [self buttonItems];
        
        CMCCButtonItem *eachItem;
        if (otherButtonItem) {
            [buttonsArray addObject:otherButtonItem];
            while((eachItem = va_arg(otherButtonItems, CMCCButtonItem *)))
            {
                [buttonsArray addObject: eachItem];
            }
            
            for(CMCCButtonItem *item in buttonsArray)
            {
                [self addButtonWithTitle:item.label];
            }
        }
        
        
        if(inCancelButtonItem)
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
        
        [self setDelegate:self];
    }
    return self;
}

- (NSInteger)addButtonItem:(CMCCButtonItem *)item
{
    NSInteger buttonIndex = [self addButtonWithTitle:item.label];
    [[self buttonItems] addObject:item];
    
    if (![self delegate])
    {
        [self setDelegate:self];
    }
    
    return buttonIndex;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
#pragma clang diagnostic pop
    // If the button index is -1 it means we were dismissed with no selection
    if (buttonIndex >= 0)
    {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY);
        CMCCButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action(item);
    }
    
    objc_setAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)buttonItems
{
    NSMutableArray *buttonItems = objc_getAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY);
    if (!buttonItems)
    {
        buttonItems = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY, buttonItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return buttonItems;
}

@end
