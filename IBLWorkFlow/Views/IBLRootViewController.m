//
//  IBLRootViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRootViewController.h"

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

@end
