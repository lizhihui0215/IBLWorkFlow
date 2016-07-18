//
//  IBLBusinessAlertViewController.h
//  CustomIOSAlertView
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 Wimagguc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBLBusinessAlertViewController;

typedef void (^OnButtonTouchUpInside)(IBLBusinessAlertViewController *alertView, int buttonIndex);

@interface IBLBusinessAlertViewController : UIViewController
- (void)show;
+ (instancetype)alertWithTitle:(NSString *)title image:(UIImage *)image;

@property (nonatomic,copy) OnButtonTouchUpInside buttonTapped;

@end
