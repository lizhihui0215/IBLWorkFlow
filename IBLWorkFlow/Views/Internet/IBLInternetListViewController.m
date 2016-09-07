//
//  IBLInternetListViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 06/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLInternetListViewController.h"
#import "IBLInternetListCell.h"
#import "IBLInternetDetailTableViewController.h"

@interface IBLInternetListViewController ()

@end

@implementation IBLInternetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerRefresh = YES;
    self.footerRefresh = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.viewModel fetchRecoredsWithIsRefresh:YES
                               completeHandler:^(NSError *error) {
        [tableView.mj_header endRefreshing];
        if (![self showAlertWithError:error]) {
            [self.tableView reloadData];
        }
    }];
}

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self.viewModel fetchRecoredsWithIsRefresh:NO
                               completeHandler:^(NSError *error) {
                                   [tableView.mj_footer endRefreshing];
                                   if (![self showAlertWithError:error]) {
                                       [self.tableView reloadData];
                                   }
                               }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"IBLInternetListCell" configuration:^(IBLInternetListCell *cell) {
        cell.scriptTypeLabel.text = [self.viewModel scriptTypeAtIndexPath:indexPath];
        cell.usernameLabel.text = [self.viewModel usernameAtIndexPath:indexPath];
        cell.handleResultLabel.text = [self.viewModel handleResultAtIndexPath:indexPath];
        cell.handleStatusImageView.image = [self.viewModel handleStatusImageAtIndexPath:indexPath];
        cell.lastModifyDateLabel.text = [self.viewModel lastModifyDateAtIndexPath:indexPath];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLInternetListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IBLInternetListCell" forIndexPath:indexPath];
    cell.scriptTypeLabel.text = [self.viewModel scriptTypeAtIndexPath:indexPath];
    cell.usernameLabel.text = [self.viewModel usernameAtIndexPath:indexPath];
    cell.handleResultLabel.text = [self.viewModel handleResultAtIndexPath:indexPath];
    cell.handleStatusImageView.image = [self.viewModel handleStatusImageAtIndexPath:indexPath];
    cell.lastModifyDateLabel.text = [self.viewModel lastModifyDateAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"NavigationToOnlineDetail" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"NavigationToOnlineDetail"]) {
       IBLInternetDetailTableViewController *internetDetailViewController = [segue destinationViewController];
        internetDetailViewController.networkRecord = [self.viewModel networkRecordAtIndexPath:sender];
    }
}


@end
