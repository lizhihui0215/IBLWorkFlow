//
//  IBLCreateAccountViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//


#import "IBLCreateAccountViewModel.h"
#import "IBLCreateAccountTableViewController.h"
#import "IBLSearchViewController.h"

@class IBLCreateAccountViewController;
@protocol IBLCreateAccountViewControllerDelegate <NSObject>

- (void)createAccountViewController:(IBLCreateAccountViewController *)createAccountViewController commit:(IBLOrder *)commit;

@end

@interface IBLCreateAccountViewController : PCCWViewController <IBLCreateAccountTableViewControllerDataSource>

@property (nonatomic, strong) IBLCreateAccountViewModel *viewModel;

@property (nonatomic, weak) id<IBLCreateAccountViewControllerDelegate> delegate;

@end
