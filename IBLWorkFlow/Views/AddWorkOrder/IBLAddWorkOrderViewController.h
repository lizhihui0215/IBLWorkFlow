//
//  IBLAddWorkOrderViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewController.h"
#import "IBLAddWorkOrderViewModel.h"

@class IBLAddWorkOrderViewController;

@protocol IBLAddWorkOrderViewControllerDelegate <NSObject>

- (void)addWorkOrderTableDidCommit:(IBLAddWorkOrderViewController *)addWorkOrderViewController;

@end


@interface IBLAddWorkOrderViewController : IBLViewController

@property (nonatomic, strong) IBLAddWorkOrderViewModel *viewModel;

@property (nonatomic, weak) id<IBLAddWorkOrderViewControllerDelegate> delegate;

@end
