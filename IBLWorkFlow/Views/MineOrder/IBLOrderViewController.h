//
//  IBLOrderViewController.h
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLTableViewController.h"
#import "RESideMenu.h"
#import "IBLMineOrderViewModel.h"

static NSString *const OrderActionForwardIdentifier = @"ForwardForSearch";

@interface IBLOrderViewController : IBLTableViewController

@property (nonatomic, strong) IBLMineOrderViewModel *viewModel;

@end
