//
//  IBLUserSearchTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLUserSearchViewModel.h"

@class IBLUserSearchTableViewController;
@class IBLUserSearchResult;
@class IBLRegion;


@protocol IBLUserSearchTableViewControllerDelegate <NSObject>

- (void)userSearchTableViewController:(IBLUserSearchTableViewController *)tableViewController
                         didEndSearch:(IBLUserSearchResult *)searchResult;

- (IBLUserSearchType)userSearchType;
@end

@interface IBLUserSearchTableViewController : UITableViewController

@property  (nonatomic, weak) id<IBLUserSearchTableViewControllerDelegate> delegate;

@end
