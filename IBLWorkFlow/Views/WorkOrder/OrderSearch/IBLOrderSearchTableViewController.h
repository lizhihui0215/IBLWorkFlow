//
//  IBLOrderSearchTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewController.h"

@protocol IBLOrderSearchTableViewControllerDataSource <NSObject>

@end


@interface IBLOrderSearchTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLOrderSearchTableViewControllerDataSource> searchDataSource;

@end
