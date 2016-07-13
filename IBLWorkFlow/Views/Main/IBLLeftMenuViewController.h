//
//  IBLLeftMenuViewController.h
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLTableViewController.h"
#import "RESideMenu.h"
#import "IBLLeftMenuViewModel.h"

@interface IBLLeftMenuViewController : IBLTableViewController <RESideMenuDelegate>

@property (nonatomic, strong) IBLLeftMenuViewModel *viewModel;

@end