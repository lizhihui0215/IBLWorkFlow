//
//  IBLOrderSearchViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//


#import "IBLOrderSearchTableViewController.h"
#import "IBLOrderSearchViewModel.h"

@class IBLOrderSearchViewController;

@protocol IBLOrderSearchDelegate <NSObject>

- (void)orderSearchViewController:(IBLOrderSearchViewController *)searchViewController
                  didSearchResult:(IBLOrderSearchResult *)searchResult;

@end

@interface IBLOrderSearchViewController : PCCWViewController

@property (nonatomic, weak) id<IBLOrderSearchDelegate> delegate;

@property (nonatomic, strong) IBLOrderSearchViewModel *viewModel;

@end
