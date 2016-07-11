//
//  IBLWorkFlowManagerViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLWorkFlowManagerViewController.h"

@interface IBLWorkFlowManagerViewController ()

@end

@implementation IBLWorkFlowManagerViewController
- (void)viewDidLoad{
    [super viewDidLoad];
}
- (IBAction)pushViewController:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"Pushed Controller";
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
