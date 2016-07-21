//
//  IBLSearchViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewController.h"
#import "IBLSearchViewModel.h"
#import "IBLOperatorSearchViewModel.h"

@class IBLSearchViewController;

@protocol IBLSearchViewControllerDelegate <NSObject>

- (void)searchViewController:(IBLSearchViewController *)searchViewController
                   didSelectedResult:(id)searchResult;

@end

@interface IBLSearchViewController : IBLTableViewController

@property (nonatomic, weak) id<IBLSearchViewControllerDelegate> searchDelegate;

@property (nonatomic, strong) IBLSearchViewModel *viewModel;

@end
