//
//  UINavigationBar+IBLExtension.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "UINavigationBar+IBLExtension.h"

@implementation UINavigationBar (IBLExtension)

+ (void)setupAppearance {
    UIColor *color = [UIColor colorWithHex:0x1E84E5];
    
    [UINavigationBar appearance].barTintColor = color;
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [UINavigationBar appearance].titleTextAttributes = @{
                                                         NSForegroundColorAttributeName:  [UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                                                         };
    
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
                                                         forBarMetrics:UIBarMetricsDefault];
}

@end
