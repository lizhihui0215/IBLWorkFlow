//
//  IBLMineWorkFlowViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLMineWorkFlowViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface IBLMineWorkFlowViewController ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@end

@implementation IBLMineWorkFlowViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.segmentedControl.sectionTitles = @[@"已派单",@"处理中",@"转发中",@"已完成",@"作废"];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self.segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        
        NSDictionary *fontAttributes = @{NSForegroundColorAttributeName : [UIColor blueColor],
                                         NSFontAttributeName : [UIFont systemFontOfSize:13]};
        
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title
                                                                        attributes:fontAttributes];
        return attString;
    }];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorHeight = 2.0f;

    
}

@end
