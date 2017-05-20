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
#import "IBLAddWorkOrderTableViewController.h"
#import "IBLUserDetailTableViewController.h"

@interface IBLUserSearchResultViewController ()

@end

@implementation IBLUserSearchResultViewController

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

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self.viewModel reloadWithIsRefresh:NO
                        completeHandler:^(NSError *error) {
                            [tableView reloadData];
                            [footer endRefreshing];
                        }];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self.viewModel reloadWithIsRefresh:YES
                        completeHandler:^(NSError *error) {
                            [tableView reloadData];
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
- (IBAction)userDetailButtonPressed:(UIButton *)sender {
    CGPoint location = [sender.superview convertPoint:sender.center toView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];

    [self performSegueWithIdentifier:@"NavigationToUserDetail" sender:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLUserSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IBLUserSearchResultCell" forIndexPath:indexPath];
    
    cell.identifierLabel.text = [self.viewModel accountAtIndexPath:indexPath];

    cell.nameLabel.text = [self.viewModel nameAtIndexPath:indexPath];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:[self segueIdentifiers][@(self.viewModel.searchType)] sender:indexPath];
}

- (NSDictionary *)segueIdentifiers{
    return @{@(IBLUserSearchTypeRenew) : @"NavigationToRenew" ,
             @(IBLUserSearchTypeExchangeProduct) : @"NavigationToExchangeProduct",
             @(IBLUserSearchTypeAddWorkOrder) : @"NavigationToAddWorkOrder"};
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"NavigationToUserDetail"]) {
        IBLUserDetailTableViewController *userDetailTableViewController = [segue destinationViewController];
        
        IBLOrder *order = [[IBLOrder alloc] init];
        order.userIdentifier = [@([self.viewModel identifierAtIndexPath:sender]) stringValue];
        order.userAccount = [self.viewModel accountAtIndexPath:sender];
        userDetailTableViewController.order = order;
    }else{
        id searchResult = [self.viewModel searchResultAtIndexPath:sender];
        
        switch (self.viewModel.searchType) {
            case IBLUserSearchTypeRenew: {
                IBLRenewViewController *renewViewController = [segue destinationViewController];
                
                renewViewController.viewModel = [IBLRenewViewModel modelWithUser:searchResult];
                break;
            }
            case IBLUserSearchTypeExchangeProduct: {
                
                IBLExchangeProductViewController *exchangeProductViewController = [segue destinationViewController];
                
                exchangeProductViewController.viewModel = [IBLExchangeProductViewModel modelWithUser:searchResult];
                break;
            }
            case IBLUserSearchTypeAddWorkOrder:{
                IBLAddWorkOrderTableViewController *addWorkOrderTableViewController = [segue destinationViewController];
                [addWorkOrderTableViewController setRelateUser:searchResult];
                break;
            }
        }

    }
}


@end
