//
//  IBLUserSearchTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserSearchTableViewController.h"
#import "IBLUserSearchResultViewController.h"
#import "IBLSearchViewController.h"
#import "IBLAppRepository.h"
#import "IBLUserSearchViewModel.h"
#import "IBLRegion.h"
#import "IBLUserSearchResultViewModel.h"

@interface IBLUserSearchTableViewController ()<IBLSearchViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIdentifierTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UITextField *custTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactPhoneTextField;

@property(nonatomic, strong) IBLRegion *region;

@property (nonatomic, strong) IBLUserSearchResult *searchResult;
@end

@implementation IBLUserSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResult = [[IBLUserSearchResult alloc] init];
    self.searchResult.custType = [IBLAppRepository appConfiguration].custType;
    self.custTypeTextField.text = [self userTypeNames][@(self.searchResult.custType)];
}

- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(0) : @"一般用户",
             @(1) : @"企业用户"};
}

- (IBAction)custTypeTapped:(UITapGestureRecognizer *)sender {
    IBLButtonItem *beforeTheDate = [IBLButtonItem itemWithLabel:@"一般用户"
                                                         action:^(IBLButtonItem *item) {
                                                             self.searchResult.custType = 0;
                                                             self.custTypeTextField.text = [self userTypeNames][@(0)];
                                                             [self.tableView reloadData];
                                                         }];
    
    IBLButtonItem *first = [IBLButtonItem itemWithLabel:@"企业用户"
                                                 action:^(IBLButtonItem *item) {
                                                     self.searchResult.custType = 1;
                                                     self.custTypeTextField.text = [self userTypeNames][@(1)];
                                                     [self.tableView reloadData];
                                                 }];
    
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                    title:@"请选择用户类型"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                         otherButtonItems:beforeTheDate,first,nil];
    [alert showInController:self];
}

- (IBAction)regionTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"NavigationToAreaSearch" sender:self];
}

- (IBAction)searchButtonPressed:(UIButton *)sender {
    
    IBLUserSearchType type = [self.tableViewDelegate userSearchType];
    
    NSString *account = [NSString isNull:self.accountTextField.text]  ? nil : self.accountTextField.text;
    
    NSString *username = [NSString isNull:self.usernameTextField.text]  ? nil : self.usernameTextField.text;
    
    NSString *phone = [NSString isNull:self.phoneTextField.text]  ? nil : self.phoneTextField.text;
    
    NSString *userIdentifier = [NSString isNull:self.userIdentifierTextField.text]  ? nil : self.userIdentifierTextField.text;
    
    self.searchResult.searchType = type;
    
    self.searchResult.region = self.region;
    self.searchResult.account = account;
    self.searchResult.username = username;
    self.searchResult.comName = self.enterpriseNameTextField.text;
    self.searchResult.comContact = self.enterpriseContactTextField.text;
    self.searchResult.phone = phone;
    self.searchResult.comContactPhone = self.enterpriseContactPhoneTextField.text;
    self.searchResult.userIdentifier = userIdentifier;
    self.searchResult.address = self.region.address;
    
    
    [self.tableViewDelegate userSearchTableViewController:self didEndSearch:self.searchResult];
    
    [self performSegueWithIdentifier:@"NavigationToResult" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"NavigationToResult"]) {
        IBLUserSearchType type = [self.tableViewDelegate userSearchType];
        
        IBLUserSearchResultViewController *searchResultViewController = [segue destinationViewController];
        
        searchResultViewController.viewModel = [IBLUserSearchResultViewModel modelWithSearchType:type
                                                                                    searchResult:self.searchResult];
    }else if([segue.identifier isEqualToString:@"NavigationToAreaSearch"]){
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        
        IBLSearchType type =  [self.tableViewDelegate userSearchType] == IBLUserSearchTypeRenew ? IBLSearchTypeRenewArea : IBLSearchTypeExchangeProductArea;
        
        searchViewController.viewModel = [IBLRegionSearchViewModel regionSearchModelWithSearchType:type];
        
        searchViewController.searchDelegate = self;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if([self isHiddenAtIndexPath:indexPath]) return  0;

    return 40;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)path {

    NSMutableArray *hiddenIndexPath = nil;

    if (self.searchResult.custType == 0) {
        NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        NSIndexPath *enterpriseContactPhoneIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        
        hiddenIndexPath = [@[enterpriseNameIndexPath,
                             enterpriseContactIndexPath,
                             enterpriseContactPhoneIndexPath] mutableCopy];
        
    }else{
        NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        NSIndexPath *userPhoneIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        hiddenIndexPath = [@[usernameIndexPath,
                             userPhoneIndexPath] mutableCopy];
    }
    
    NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    if ([IBLAppRepository appConfiguration].showCustType == 0) {
        [hiddenIndexPath addObject:userTypeIndexPath];
    }


    return [hiddenIndexPath containsObject:path];}

- (void)searchViewController:(IBLSearchViewController *)searchViewController
           didSelectedResult:(id)searchResult {
    IBLRegion *region = searchResult;
    switch (searchViewController.viewModel.searchType) {
        case IBLSearchTypeExchangeProductArea:
        case IBLSearchTypeRenewArea:{
            self.regionTextField.text = region.name;
            self.region = region;
            break;
        }
       
        default: break;
    }
}



@end
