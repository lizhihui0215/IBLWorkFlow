//
//  IBLOrderCell.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderCell.h"

static NSInteger const IBLOrderSegmentControlTitleWidth = 40;

@interface IBLOrderCell ()

@property (weak, nonatomic) IBOutlet UIButton *priorityButton;

@property (strong, nonatomic) NSArray<NSNumber *> *actons;

@end

@implementation IBLOrderCell

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setPriority:(IBLPriorityStatus)priority{
    UIImage *backgroundImage = nil;
    NSString *title = nil;
    switch (priority) {
        case IBLPriorityStatusEmergency: {
            backgroundImage = [UIImage imageNamed:@"emergency"];
            title = @"紧急";
            break;
        }
        case IBLPriorityStatusGeneral: {
            backgroundImage = [UIImage imageNamed:@"general"];
            title = @"一般";
            break;
        }
        case IBLPriorityStatusNoEmergency: {
            backgroundImage = [UIImage imageNamed:@"noEmergency"];
            title = @"不紧急";
            break;
        }
    }
    [self.priorityButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self.priorityButton setTitle:title forState:UIControlStateNormal];
}

- (void)setActionTitles:(NSArray<NSString *> *)titles{
    UIColor *titleColor = [UIColor colorWithHex:0x2289E6];
    NSDictionary *fontAttributes = @{NSForegroundColorAttributeName : titleColor,
                                     NSFontAttributeName : [UIFont systemFontOfSize:13]};
    self.segmentControl.titleTextAttributes = fontAttributes;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    self.segmentControl.sectionTitles = titles;
    self.segmentControl.selectedIndexTouchable = YES;
    self.segmentControlWidthConstraint.constant = [titles count] * IBLOrderSegmentControlTitleWidth;
    
}




@end
