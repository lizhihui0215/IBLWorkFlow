//
//  IBLCreateAccountViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewController.h"
#import "IBLCreateAccountViewModel.h"
#import "IBLCreateAccountTableViewController.h"
#import "IBLSearchViewController.h"

@interface IBLCreateAccountViewController : IBLViewController <IBLCreateAccountTableViewControllerDataSource>

@property (nonatomic, strong) IBLCreateAccountViewModel *viewModel;

@end
