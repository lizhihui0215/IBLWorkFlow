//
//  IBLLoginViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLLoginViewController.h"

static NSString * const NavigationToMainIdentifier = @"NavigationToMain";

@interface IBLLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation IBLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self showHUDWithMessage:@"登录中..."];
    [self.viewModel loginWithUsername:self.usernameTextField.text
                             password:self.passwordTextField.text
                      completeHandler:^(NSError *error){
                          [self hidHUD];
                          if (![self showAlertWithError:error]) {
                              [self performSegueWithIdentifier:NavigationToMainIdentifier sender:self];
                          }
                      }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
