//
//  IBLMineOrderViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLMineOrderViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "IBLMineOrderCell.h"

@interface IBLMineOrderViewController ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@end

@implementation IBLMineOrderViewController

- (UITableView *)tableView{
    return self.tableViews[self.segmentedControl.selectedSegmentIndex];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.headerRefresh = YES;
    self.fotterRefresh = YES;
    [self setupSegmentControl];
    [self setupTableViews];
}

- (void)setupSegmentControl{
    self.segmentedControl.sectionTitles = @[@"已派单",@"处理中",@"转发中",@"已完成",@"作废"];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self.segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        
        UIColor *titleColor = [UIColor blackColor];
        
        if (selected) titleColor = [UIColor colorWithHex:0x62A3EA];
        
        NSDictionary *fontAttributes = @{NSForegroundColorAttributeName : titleColor,
                                         NSFontAttributeName : [UIFont systemFontOfSize:13]};
        
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title
                                                                        attributes:fontAttributes];
        return attString;
    }];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithHex:0x107BE0];
    
    self.segmentedControl.indexChangeBlock = ^(NSInteger index){
        [self switchTableWithIndex:index];
    };
}

- (void)switchTableWithIndex:(NSInteger)index{
    if([self.viewModel numberOfRowsInSection:0] <= 0){
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)setupTableViews{
    UINib *nib = [UINib nibWithNibName:MineWorkFlowCellIdentifier bundle:nil];
    
    for (UITableView *tableView in self.tableViews) {
        [tableView registerNib:nib forCellReuseIdentifier:MineWorkFlowCellIdentifier];
        MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)tableView.mj_header;
        header.backgroundColor = [UIColor redColor];
    }
}

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    IBLOrderStatus status = [self.viewModel statusWithIndex:self.segmentedControl.selectedSegmentIndex];

    IBLFetchMineOrderList *fetch = [IBLFetchMineOrderList listWithDateRange:@""
                                                                     status:status
                                                                    account:@""
                                                                   username:@""
                                                                      phone:@""
                                                                       type:@""
                                                                    bizType:@""];
    [self.viewModel fetchMineOrderListWithIsRefresh:YES
                                              fetch:fetch
                                    completeHandler:^(NSError *error) {
                                        if (![self showAlertWithError:error]) {
                                            [tableView reloadData];
                                        }
                                    }];
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
    IBLMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:MineWorkFlowCellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}
@end
