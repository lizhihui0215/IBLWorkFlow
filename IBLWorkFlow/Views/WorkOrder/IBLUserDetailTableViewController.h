//
//  IBLUserDetailTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLOrder.h"

@interface IBLUserDetailTableViewController : UITableViewController
@property (nonatomic, strong) IBLOrder *order;
@end
