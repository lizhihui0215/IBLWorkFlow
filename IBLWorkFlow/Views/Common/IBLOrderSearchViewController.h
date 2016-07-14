//
//  IBLOrderSearchViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewController.h"
#import "IBLOrderSearchViewModel.h"

@class IBLOrderSearchViewController;
@class IBLOrderSearchResult;

@protocol IBLOrderSearchDelegate <NSObject>

- (void)orderSearchViewController:(IBLOrderSearchViewController *)searchViewController
                  didSearchResult:(IBLOrderSearchResult *)searchResult;

@end

@interface IBLOrderSearchViewController : IBLTableViewController

@property (nonatomic, strong) IBLOrderSearchViewModel *viewModel;

@property (nonatomic, weak) id<IBLOrderSearchDelegate> delegate;

@end
