//
//  IBLBusinessAlertViewController.h
//  CustomIOSAlertView
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 Wimagguc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBLBusinessAlertViewController : UIViewController
- (void)show;
+ (instancetype)alertWithTitle:(NSString *)title image:(UIImage *)image;
@end
