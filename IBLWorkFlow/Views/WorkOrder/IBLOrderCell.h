//
//  IBLOrderCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWTableViewCell.h"
#import "IBLSegmentControl.h"
#import "IBLOrder.h"


static NSString * const MineWorkFlowCellIdentifier = @"IBLOrderCell";

static NSString * const MineWorkFlowCellNibName = @"IBLOrderCell";

@interface IBLOrderCell : PCCWTableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentControlWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *workOrderTypeLabel;

//@property (weak, nonatomic) IBOutlet UILabel *orderUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@property (weak, nonatomic) IBOutlet IBLSegmentControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIButton *orderUserButton;
@property (weak, nonatomic) IBOutlet UILabel *workOrderContentLabel;

- (void)setPriority:(IBLPriorityStatus)priority;

- (void)setActionTitles:(NSArray<NSString *> *)titles;

- (void)setUserTitle:(NSString *)title;

@end
