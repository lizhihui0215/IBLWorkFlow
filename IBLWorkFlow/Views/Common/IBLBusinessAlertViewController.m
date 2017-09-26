//
//  IBLBusinessAlertViewController.m
//  CustomIOSAlertView
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 Wimagguc. All rights reserved.
//

#import "IBLBusinessAlertViewController.h"
#import "CustomIOSAlertView.h"

@interface IBLBusinessAlertViewController ()<CustomIOSAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleContainerWidthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) CustomIOSAlertView *alertView;

@end

@implementation IBLBusinessAlertViewController

+ (instancetype)alertWithTitle:(NSString *)title
                   placeholder:(NSString *)placeholder
                         image:(UIImage *)image{
    return [[self alloc] initWithTitle:title placeholder:placeholder image:image];;
}

- (instancetype)initWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                        image:(UIImage *)image
{
    self = [super initWithNibName:@"IBLBusinessAlertViewController" bundle:nil];
    if (self) {
        self.alertView = [[CustomIOSAlertView alloc] init];
        
        // Add some custom content to the alert view
        [self.alertView setContainerView:self.view];
        self.titleLabel.text = title;
        [self.titleLabel sizeToFit];
        
        self.iconImageView.image = image;
        
        self.contentTextField.placeholder = placeholder;
        
        self.titleContainerWidthConstraint.constant = CGRectGetWidth(self.titleLabel.frame) + CGRectGetWidth(self.iconImageView.frame) + 10;
        
        // Modify the parameters
        [self.alertView setButtonTitles:@[@"确认", @"取消"]];
        
        // You may use a Block, rather than a delegate.
        
        [self.alertView setUseMotionEffects:false];
        
////
////        self.buttonTapped = ^(IBLBusinessAlertViewController *alertView, NSInteger buttonIndex){
////            @strongify(self)
//            @weakify(self)
//            self.alertView.onButtonTouchUpInside = ^(CustomIOSAlertView *alertView, int buttonIndex) {
//                @strongify(self)
//                
//                if (self.buttonTapped) {
//                    self.buttonTapped(self, buttonIndex);
//                }
//                [self.alertView close];
//            };
////        };
        
        self.alertView.delegate = self;
        
        
    }
    return self;
}

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.buttonTapped) {
        self.buttonTapped(self,buttonIndex);
    }
//    [self.alertView close];
}

- (void)close{
    [self.alertView close];
}

//- (void)setButtonTapped:(OnButtonTouchUpInside)buttonTapped{
//    @weakify(self)
//    [self.alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
//        @strongify(self)
//        if (buttonTapped) {
//            buttonTapped(self, buttonIndex);
//        }
//        [alertView close];
//    }];
//}

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
