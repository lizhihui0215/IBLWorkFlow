//
//  IBLUserSearchResultViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserSearchResultViewController.h"
#import "IBLExchangeProductViewController.h"
#import "IBLRenewViewController.h"
#import "IBLUserSearchResultViewModel.h"
#import "IBLUserSearchResultCell.h"

@interface IBLUserSearchResultViewController ()

@end

@implementation IBLUserSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerRefresh = YES;
    self.footerRefresh = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self.viewModel reloadWithIsRefresh:NO
                        completeHandler:^(NSError *error) {
                            [footer endRefreshing];
                        }];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self.viewModel reloadWithIsRefresh:YES
                        completeHandler:^(NSError *error) {
                            [header endRefreshing];
                        }];
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.viewModel numberOfRowsInSection:sectionIndex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLUserSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IBLUserSearchResultCell" forIndexPath:indexPath];
    
    cell.identifierLabel.text = [self.viewModel identifierAtIndexPath:indexPath];

    cell.nameLabel.text = [self.viewModel nameAtIndexPath:indexPath];
   
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    id searchResult = [self.viewModel searchResultAtIndexPath:indexPath];

    switch (self.viewModel.searchType) {
        case IBLUserSearchTypeRenew: {
            IBLRenewViewController *renewViewController = [segue destinationViewController];
            
            renewViewController.viewModel = [[IBLRenewViewModel alloc] init];
            break;
        }
        case IBLUserSearchTypeExchangeProduct: {
            
            IBLExchangeProductViewController *exchangeProductViewController = [segue destinationViewController];
            
            exchangeProductViewController.viewModel = [[IBLExchangeProductViewModel alloc] init];
            
            break;
        }
    }
}


@end
