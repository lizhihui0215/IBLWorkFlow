//
//  IBLUserSearchResultViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//


#import "IBLUserSearchResultViewModel.h"

@class IBLUserSearchResultViewModel;

@interface IBLUserSearchResultViewController : PCCWTableViewController

@property (nonatomic, strong) IBLUserSearchResultViewModel *viewModel;

@end
