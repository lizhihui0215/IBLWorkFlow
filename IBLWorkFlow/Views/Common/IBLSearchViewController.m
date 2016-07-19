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
    [self reloadWithSearchInfo:nil isRefresh:YES];
}

- (void)reloadWithSearchInfo:(id)searchInfo
                   isRefresh:(BOOL)isRefresh{
    self.searchInfo = searchInfo;
    [self.viewModel fetchSearchContentWithSearchInfo:self.searchInfo
                                           isRefresh:isRefresh
                                     completeHandler:^(NSError *error) {
                                         if(![self showAlertWithError:error]){
                                             [self.tableView reloadData];
                                         }
                                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self reloadWithSearchInfo:[self searchInfoWithKeyword:textField.text]
                     isRefresh:YES];
}

- (id)searchInfoWithKeyword:(NSString *)keyword{
    id searchInfo = nil;
    switch (self.viewModel.searchType) {
        case IBLSearchTypeForward: {
            searchInfo = @{kSearchOperatorName : keyword};
            break;
        }
    }
    
    return searchInfo;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self reloadWithSearchInfo:[self searchInfoWithKeyword:self.searchTextField.text]
                     isRefresh:NO];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self reloadWithSearchInfo:[self searchInfoWithKeyword:self.searchTextField.text]
                     isRefresh:YES];
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
        case IBLSearchTypeForward: {
            cell = [self configurationForwardCellWithTableView:tableView indexPath:indexPath];
            break;
        }
    }
    return cell;
}

- (UITableViewCell *)configurationForwardCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    IBLSearchFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:IBLSearchFieldCellIdentifier forIndexPath:indexPath];
    
    IBLForwardSearchViewModel *fowardSearchViewModel = (IBLForwardSearchViewModel *)self.viewModel;
    
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
