//
//  IBLTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface IBLTableViewController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, weak) id<IBLTableViewControllerDelegate> delegate;
@end

@implementation IBLTableViewController

- (UITableView *)tableView{
    return self.tableViews[0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.headerRefresh = NO;
    self.fotterRefresh = NO;
    for (UITableView *tableView in self.tableViews) {
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset: UIEdgeInsetsZero];
        }
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins: UIEdgeInsetsZero];
        }
    }
    
    for (UITableView *tableView in self.tableViews) {
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
    }
    
    [self removeTableFooterView];
    
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"emptyTableView"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if (!self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (MJRefreshStateHeader *)defaultRefreshHeader {
    return [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewHeaderWillRefresh:)];
}

- (MJRefreshBackStateFooter *)defaultRefreshFooter{
    return [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewFooterWillRefresh:)];
}

- (void)setHeaderRefresh:(BOOL)headerRefresh{
    _headerRefresh = headerRefresh;
    for (UITableView *tableView in self.tableViews) {
        tableView.mj_header = _headerRefresh ? [self defaultRefreshHeader] : nil;
    }
}

- (void)setFotterRefresh:(BOOL)fotterRefresh{
    _fotterRefresh = fotterRefresh;
    for (UITableView *tableView in self.tableViews) {
        tableView.mj_footer = _fotterRefresh ? [self defaultRefreshFooter] : nil;
    }
}

- (void)tableViewFooterWillRefresh:(MJRefreshBackNormalFooter *)footer{
    UITableView *theTableView = nil;
    for (UITableView *tableView in self.tableViews) {
        if (tableView.mj_footer == footer){
            theTableView = tableView;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:footerBeginRefresh:)]) {
        [self.delegate tableView:theTableView footerBeginRefresh:footer];
    }
}

- (void)tableViewHeaderWillRefresh:(MJRefreshNormalHeader *)header{
    UITableView *theTableView = nil;
    for (UITableView *tableView in self.tableViews) {
        if (tableView.mj_header == header){
            theTableView = tableView;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:headerBeginRefresh:)]) {
        [self.delegate tableView:theTableView headerBeginRefresh:header];
    }
}

- (void)removeTableFooterView {
    for (UITableView *tableView in self.tableViews) {
        UIView *view = [[UIView alloc] init];
        
        view.backgroundColor = [UIColor whiteColor];
        
        tableView.tableFooterView = view;
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
