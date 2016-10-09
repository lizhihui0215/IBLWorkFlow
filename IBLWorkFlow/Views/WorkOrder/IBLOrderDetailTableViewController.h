//
//  IBLOrderDetailTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLStaticTableViewController.h"
#import "IBLOrder.h"

@interface IBLOrderDetailTableViewController : IBLStaticTableViewController

@property (nonatomic, strong) IBLOrder *order;

@end
