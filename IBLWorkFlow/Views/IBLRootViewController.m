//
//  IBLRootViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRootViewController.h"
#import "IBLLoginViewController.h"
static NSString * const NavigationToLoginIdentifier = @"NavigationToLogin";

@interface IBLRootViewController ()

@end

@implementation IBLRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSegueWithIdentifier:NavigationToLoginIdentifier sender:self];
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
     IBLLoginViewController *loginViewController = [segue destinationViewController];
     
     loginViewController.viewModel = [[IBLLoginViewModel alloc] init];
     
 }

@end
