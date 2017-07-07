//
//  IBLLoginViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLLoginViewController.h"
#import "IBLException.h"
#import "BPush.h"
#import "IBLUserRepository.h"

static NSString * const NavigationToMainIdentifier = @"NavigationToMain";

@interface IBLLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *LANTextField;

@property (weak, nonatomic) IBOutlet UITextField *WLANTextField;

@end

@implementation IBLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameTextField.text = [self.viewModel lastUsername];
    self.passwordTextField.text = [self.viewModel lastPassword];
    self.LANTextField.text = [self.viewModel lastLAN];
    self.WLANTextField.text = [self.viewModel lastWLAN];
    [self.viewModel setLAN:self.LANTextField.text];
    [self.viewModel setWLAN:self.WLANTextField.text];
    self.LANTextField.keyboardType = UIKeyboardTypeURL;
    self.WLANTextField.keyboardType = UIKeyboardTypeURL;
    [self.LANTextField setDidEndEditingBlock:^(UITextField *textField) {
        [self.viewModel setLAN:textField.text];
    }];
    
    [self.LANTextField setShouldEndEditingBlock:^BOOL(UITextField *textField) {
        if ([NSString isNull:textField.text]) return YES;
        BOOL isValidate = [IBLUtilities validateDomain:textField.text];
        if (!isValidate){
            NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{kExceptionCode : @(0),
                                                                            kExceptionMessage : @"请输入正确的域名!"}];
            
            [self showAlertWithError:error];
        }
        
        return isValidate;
    }];
    
    [self.WLANTextField setShouldEndEditingBlock:^BOOL(UITextField *textField) {
        if ([NSString isNull:textField.text]) return YES;
        BOOL isValidate = [IBLUtilities validateDomain:textField.text];
        if (!isValidate){
            NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{kExceptionCode : @(0),
                                                                            kExceptionMessage : @"请输入正确的域名!"}];
            
            [self showAlertWithError:error];
        }
        
        return isValidate;
    }];
    
    [self.WLANTextField setDidEndEditingBlock:^(UITextField *textField) {
        [self.viewModel setWLAN:textField.text];
    }];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self showHUDWithMessage:@"登录中..."];
    [self.viewModel loginWithUsername:self.usernameTextField.text
                             password:self.passwordTextField.text
                      completeHandler:^(NSError *error){
                          [self hidHUD];
                          if (![self showAlertWithError:error]) {
                              IBLUser *user = [IBLUserRepository user];
                              [BPush setTag:user.identifier
                        withCompleteHandler:^(id result, NSError *error) {
                            NSLog(@"result %@ error %@",result,error);
                        }];
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
