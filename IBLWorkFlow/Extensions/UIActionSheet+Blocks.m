//
//  UIActionSheet+Blocks.m
//  CMCC
//
//  Created by 李智慧 on 11/10/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *CMCC_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";
static NSString *CMCC_DISMISSAL_ACTION_KEY = @"com.random-ideas.DISMISSAL_ACTION";
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
@implementation UIActionSheet (Blocks)
#pragma clang diagnostic pop

- (id)initWithTitle:(NSString *)inTitle
            message:(NSString *)inMessage
   cancelButtonItem:(IBLButtonItem *)inCancelButtonItem
    otherButtonItem:(IBLButtonItem *)otherButtonItem
   otherButtonItems:(va_list)otherButtonItems
{
    if((self = [self initWithTitle:inTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        IBLButtonItem *eachItem;
        if (otherButtonItem)
        {
            [buttonsArray addObject: otherButtonItem];
            while((eachItem = va_arg(otherButtonItems, IBLButtonItem *)))
            {
                [buttonsArray addObject: eachItem];
            }
        }
        
        for(IBLButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }
        
//        if(inDestructiveItem)
//        {
//            [buttonsArray addObject:inDestructiveItem];
//            NSInteger destIndex = [self addButtonWithTitle:inDestructiveItem.label];
//            [self setDestructiveButtonIndex:destIndex];
//        }
        
        if(inCancelButtonItem)
        {
            [buttonsArray addObject:inCancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:inCancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
        }
        
        objc_setAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return self;
}

- (NSInteger)addButtonItem:(IBLButtonItem *)item
{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY);
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	return buttonIndex;
}

- (void)setDismissalAction:(void(^)())dismissalAction
{
    objc_setAssociatedObject(self, (__bridge const void *) CMCC_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, (__bridge const void *) CMCC_DISMISSAL_ACTION_KEY, dismissalAction, OBJC_ASSOCIATION_COPY);
}

- (void(^)())dismissalAction
{
    return objc_getAssociatedObject(self, (__bridge const void *) CMCC_DISMISSAL_ACTION_KEY);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Action sheets pass back -1 when they're cleared for some reason other than a button being 
    // pressed.
    if (buttonIndex >= 0)
    {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY);
        IBLButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action(item);
    }
    
    if (self.dismissalAction) self.dismissalAction();
    
    objc_setAssociatedObject(self, (__bridge const void *) CMCC_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *) CMCC_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
}

@end

