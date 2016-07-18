//
//  IBLBusinessAlertViewController.m
//  CustomIOSAlertView
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 Wimagguc. All rights reserved.
//

#import "IBLBusinessAlertViewController.h"
#import "CustomIOSAlertView.h"

@interface IBLBusinessAlertViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) CustomIOSAlertView *alertView;

@end

@implementation IBLBusinessAlertViewController

+ (instancetype)alertWithTitle:(NSString *)title image:(UIImage *)image{
    
    IBLBusinessAlertViewController *controller =  [[IBLBusinessAlertViewController alloc] initWithNibName:@"IBLBusinessAlertViewController" bundle:nil];
    controller.alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [controller.alertView setContainerView:controller.view];
    controller.titleLabel.text = title;
    [controller.titleLabel sizeToFit];
    
    controller.iconImageView.image = image;

    controller.titleContainerWidthConstraint.constant = CGRectGetWidth(controller.titleLabel.frame) + CGRectGetWidth(controller.iconImageView.frame) + 10;

    // Modify the parameters
    [controller.alertView setButtonTitles:@[@"确认", @"取消"]];
    
    // You may use a Block, rather than a delegate.
    @weakify(controller)
    [controller.alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        @strongify(controller)
        if (controller.buttonTapped) {
            controller.buttonTapped(controller, buttonIndex);
        }
        [alertView close];
    }];
    
    [controller.alertView setUseMotionEffects:false];
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    

}

- (void)updateViewConstraints{
    [super updateViewConstraints];
}

- (void)show{
    [self.alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
