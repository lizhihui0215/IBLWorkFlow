//
//  IBLInternetDetailTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLNetworkRecord.h"
#import "IBLStaticTableViewController.h"

@interface IBLInternetDetailTableViewController : IBLStaticTableViewController

@property (nonatomic, strong) IBLNetworkRecord *networkRecord;

@end
