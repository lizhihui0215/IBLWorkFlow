//
//  IBLOrderFlowViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderFlowViewController.h"
#import "IBLOrderFlowCell.h"

@interface IBLOrderFlowViewController ()

@end

@implementation IBLOrderFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerRefresh = YES;
    self.footerRefresh = NO;
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.viewModel numberOfRowsInSection:sectionIndex];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self.viewModel startFetchWithCompleteHandler:^(NSError *error) {
        if (![self showAlertWithError:error]) {
            [self.tableView reloadData];
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLOrderFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IBLOrderFlowCell" forIndexPath:indexPath];
    
    return cell;
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
