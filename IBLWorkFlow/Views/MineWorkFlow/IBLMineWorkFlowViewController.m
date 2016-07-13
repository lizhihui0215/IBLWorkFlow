//
//  IBLMineWorkFlowViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLMineWorkFlowViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "IBLMineWorkFlowCell.h"

@interface IBLMineWorkFlowViewController ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@end

@implementation IBLMineWorkFlowViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.headerRefresh = YES;
    [self setupSegmentControl];
    [self setupTableViews];
}

- (void)setupSegmentControl{
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

- (void)setupTableViews{
    UINib *nib = [UINib nibWithNibName:MineWorkFlowCellIdentifier bundle:nil];
    
    for (UITableView *tableView in self.tableViews) {
        [tableView registerNib:nib forCellReuseIdentifier:MineWorkFlowCellIdentifier];
//        tableView.mj_header.lastupdatedtimeLabel.backgroundColor = [UIColor redColor];
        MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)tableView.mj_header;
        header.backgroundColor = [UIColor redColor];
    }
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLMineWorkFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:MineWorkFlowCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
