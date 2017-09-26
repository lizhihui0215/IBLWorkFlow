//
//  IBLBusinessAlertViewController.h
//  CustomIOSAlertView
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 Wimagguc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBLBusinessAlertViewController;

typedef void (^OnButtonTouchUpInside)(IBLBusinessAlertViewController *alertView, NSInteger buttonIndex);

@interface IBLBusinessAlertViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (nonatomic,copy) OnButtonTouchUpInside buttonTapped;

+ (instancetype)alertWithTitle:(NSString *)title
                   placeholder:(NSString *)placeholder
                         image:(UIImage *)image;

- (void)show;

- (void)close;

@end
