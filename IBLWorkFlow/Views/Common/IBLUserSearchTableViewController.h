//
//  IBLUserSearchTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLStaticTableViewController.h"
#import "IBLUserSearchViewModel.h"

@class IBLUserSearchTableViewController;
@class IBLUserSearchResult;
@class IBLRegion;


@protocol IBLUserSearchTableViewControllerDelegate <NSObject>

- (void)userSearchTableViewController:(IBLUserSearchTableViewController *)tableViewController
                         didEndSearch:(IBLUserSearchResult *)searchResult;

- (IBLUserSearchType)userSearchType;
@end

@interface IBLUserSearchTableViewController : IBLStaticTableViewController

@property  (nonatomic, weak) id<IBLUserSearchTableViewControllerDelegate> tableViewDelegate;

@end
