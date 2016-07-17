//
//  IBLMineOrderCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewCell.h"
#import "HMSegmentedControl.h"
#import "IBLOrder.h"


static NSString * const MineWorkFlowCellIdentifier = @"IBLMineOrderCell";

static NSString * const MineWorkFlowCellNibName = @"IBLMineOrderCell";

@interface IBLMineOrderCell : IBLTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *workOrderTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderUserLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentControl;

- (void)setPriority:(IBLPriorityStatus)priority;

@end
