//
//  IBLSearchViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSearchViewController.h"
#import "IBLSearchFieldCell.h"

@interface IBLSearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) id searchInfo;
@end

@implementation IBLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerRefresh = YES;
    self.footerRefresh = YES;
    
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    [self reloadWithSearchInfo:nil isRefresh:YES completeHandler:nil];
}

- (void)reloadWithSearchInfo:(id)searchInfo
                   isRefresh:(BOOL)isRefresh
             completeHandler:(void (^)(NSError *error))completeHandler{
    self.searchInfo = searchInfo;
    [self showHUDWithMessage:nil];
    [self.viewModel fetchSearchContentWithSearchInfo:self.searchInfo
                                           isRefresh:isRefresh
                                     completeHandler:^(NSError *error) {
                                         [self hidHUD];
                                         if(![self showAlertWithError:error]){
                                             [self.tableView reloadData];
                                         }
                                         if(completeHandler) completeHandler(error);
                                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self reloadWithSearchInfo:[self searchInfoWithKeyword:textField.text] isRefresh:YES completeHandler:nil];
}

- (id)searchInfoWithKeyword:(NSString *)keyword{
    id searchInfo = nil;
    switch (self.viewModel.searchType) {
        case IBLSearchTypeSend:
        case IBLSearchTypeForward:
        case IBLSearchTypeAddOrderOperator:{
            searchInfo = @{kSearchOperatorName : keyword};
            break;
        }
        case IBLSearchTypeExchangeProductArea:
        case IBLSearchTypeRenewArea:
        case IBLSearchTypeCreateAccountArea:
        case IBLSearchTypeAddOrderArea:{
            searchInfo = @{kSearchAreaName : keyword};
            break;
        }
        case IBLSearchTypeCreateAccountProduct:
        case IBLSearchTypeAddOrderProduct:{
            searchInfo = @{kSearchProductName : keyword};
            break;
        }
        
    }
    
    return searchInfo;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self reloadWithSearchInfo:[self searchInfoWithKeyword:self.searchTextField.text]
                     isRefresh:NO
               completeHandler:^(NSError *error) {
                   [footer endRefreshing];
               }];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self reloadWithSearchInfo:[self searchInfoWithKeyword:self.searchTextField.text]
                     isRefresh:YES
               completeHandler:^(NSError *error) {
                   [header endRefreshing];
               }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id searchResult = [self.viewModel searchResultAtIndexPath:indexPath];
    [self.searchDelegate searchViewController:self didSelectedResult:searchResult];
    [self.navigationController popViewControllerAnimated:YES];
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
    UITableViewCell *cell = nil;
    switch (self.viewModel.searchType) {
        case IBLSearchTypeSend:
        case IBLSearchTypeForward:
        case IBLSearchTypeAddOrderOperator:{
            cell = [self configurationOperatorCellWithTableView:tableView indexPath:indexPath];
            break;
        }
        case IBLSearchTypeExchangeProductArea:
        case IBLSearchTypeRenewArea:
        case IBLSearchTypeCreateAccountArea:
        case IBLSearchTypeAddOrderArea:{
            cell = [self configurationRegionCellWithTableView:tableView indexPath:indexPath];
            break;
        }
        case IBLSearchTypeCreateAccountProduct:
        case IBLSearchTypeAddOrderProduct:{
            cell = [self configurationProductCellWithTableView:tableView indexPath:indexPath];
            break;
        }
    }
    return cell;
}

- (UITableViewCell *)configurationProductCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    IBLSearchFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:IBLSearchFieldCellIdentifier forIndexPath:indexPath];
    IBLProductSearchViewModel *productSearchViewModel = (IBLProductSearchViewModel *) self.viewModel;
    cell.nameLabel.text = [productSearchViewModel nameAtIndexPath:indexPath];
    
    return cell;
}

- (UITableViewCell *)configurationRegionCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    IBLSearchFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:IBLSearchFieldCellIdentifier forIndexPath:indexPath];
    IBLRegionSearchViewModel *regionSearchViewModel = (IBLRegionSearchViewModel *) self.viewModel;
    cell.nameLabel.text = [regionSearchViewModel nameAtIndexPath:indexPath];

    return cell;
}


- (UITableViewCell *)configurationOperatorCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    IBLSearchFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:IBLSearchFieldCellIdentifier forIndexPath:indexPath];
    
    IBLOperatorSearchViewModel *fowardSearchViewModel = (IBLOperatorSearchViewModel *)self.viewModel;
    
    cell.nameLabel.text = [fowardSearchViewModel nameAtIndexPath:indexPath];
    
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
