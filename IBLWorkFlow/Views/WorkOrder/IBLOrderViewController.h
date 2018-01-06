//
//  IBLOrderViewController.h
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//


#import "RESideMenu.h"
#import "IBLOrderViewModel.h"
#import "IBLSearchViewController.h"
#import "HMSegmentedControl.h"

static NSString *const OrderActionForwardIdentifier = @"ForwardForSearch";

static NSString *const OrderActionSendIdentifier = @"SendForSearch";

static NSString *const NavigationToCreateAccountIdentifier = @"NavigationToCreateAccount";

@interface IBLOrderViewController : PCCWTableViewController <IBLSearchViewControllerDelegate>

@property (nonatomic, strong) IBLOrderViewModel *viewModel;

@property (nonatomic, assign) IBLOrderStatus status;


@end
