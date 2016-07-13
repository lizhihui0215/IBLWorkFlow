//
//  IBLMainViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLMainViewController.h"
#import "IBLLeftMenuViewController.h"

@interface IBLMainViewController ()

@end

@implementation IBLMainViewController
- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowEnabled = YES;
    self.contentViewInPortraitOffsetCenterX = 80;
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    
    IBLLeftMenuViewController *leftMenuViewController = (IBLLeftMenuViewController *)self.leftMenuViewController;
    leftMenuViewController.viewModel = [[IBLLeftMenuViewModel alloc] init];
    
    self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
