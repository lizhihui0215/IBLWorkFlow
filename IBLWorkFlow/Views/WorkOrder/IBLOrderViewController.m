//
//  IBLOrderViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLOrderViewController.h"
#import "HMSegmentedControl.h"
#import "IBLOrderCell.h"
#import "IBLOrderSearchViewController.h"
#import "IBLOrderViewModel.h"
#import "IBLBusinessAlertViewController.h"
#import "IBLSearchViewController.h"
#import "IBLCreateAccountViewController.h"

static NSString *const NavigationToOrderSearchIdentifier = @"NavigationToOrderSearch";

@interface IBLOrderViewController () <IBLOrderSearchDelegate>

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;

@end

@implementation IBLOrderViewController

- (UITableView *)tableView{
    UITableView *theTableView = self.tableViews[self.segmentedControl.selectedSegmentIndex];
    
    for (UITableView *tableView in self.tableViews) tableView.hidden = theTableView != tableView;

    return theTableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = [self.viewModel title];
    self.headerRefresh = YES;
    self.footerRefresh = YES;
    [self setupSegmentControl];
    [self setupTableViews];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupSegmentControl{
    self.segmentedControl.sectionTitles = [self.viewModel segmentedControlTitles];
    
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
    [self.viewModel setIndex:index];
    if([self.viewModel numberOfRowsInSection:0] <= 0){
        [self.tableView.mj_header beginRefreshing];
    }
    [self.tableView reloadData];
}

- (void)setupTableViews{
    UINib *nib = [UINib nibWithNibName:MineWorkFlowCellIdentifier bundle:nil];
    
    for (UITableView *tableView in self.tableViews) {
        [tableView registerNib:nib forCellReuseIdentifier:MineWorkFlowCellIdentifier];
        MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)tableView.mj_header;
        header.backgroundColor = [UIColor colorWithHex:0xCECFCE];
        tableView.backgroundColor = [UIColor colorWithHex:0xCECFCE];
    }
}

- (void)tableView:(UITableView *)tableView footerBeginRefresh:(MJRefreshBackStateFooter *)footer{
    [self.viewModel fetchOrderListWithIndex:self.segmentedControl.selectedSegmentIndex
                                  isRefresh:NO
                            completeHandler:^(NSError *error) {
                                [footer endRefreshing];
                                if (![self showAlertWithError:error]) {
                                    [tableView reloadData];
                                }
                            }];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{

    [self.viewModel fetchOrderListWithIndex:self.segmentedControl.selectedSegmentIndex
                                  isRefresh:YES
                            completeHandler:^(NSError *error) {
                                [header endRefreshing];
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
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.viewModel numberOfRowsInSection:sectionIndex];
}

- (IBAction)orderUserButtonPressed:(UIButton *)button{
    NSIndexPath *indexPath = nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:MineWorkFlowCellIdentifier forIndexPath:indexPath];
    cell.workOrderTypeLabel.text = [self.viewModel workOrderTypAtIndexPath:indexPath];
    [cell setUserTitle:[self.viewModel usernameAtIndexPath:indexPath]];
    cell.dateLabel.text = [self.viewModel dateAtIndexPath:indexPath];
    [cell setPriority:[self.viewModel orderPriorityAtIndexPath:indexPath]];
    
    NSArray *titles = [self.viewModel orderActionsTitlesAtIndexPath:indexPath];
    [cell setActionTitles:titles];
    cell.workOrderContentLabel.text = [self.viewModel orderContentAtIndexPath:indexPath];
    @weakify(self);
    cell.segmentControl.indexChangeBlock = ^(NSInteger index){
        @strongify(self);
        [self segmentControlTappedWithAction:[self.viewModel actionInIndexPath:indexPath atIndex:index] indexPath:indexPath];
    };
    return cell;
}

- (NSDictionary *)segueIdentifierMapForSearch{
    return @{@(IBLOrderActionForward) : OrderActionForwardIdentifier,
             @(IBLOrderActionSend) : OrderActionSendIdentifier,
             @(IBLOrderActionCreate) : NavigationToCreateAccountIdentifier};
}

- (void)segmentControlTappedWithAction:(IBLOrderAction)action
                             indexPath:(NSIndexPath *)indexPath{
    switch (action) {
        case IBLOrderActionForward:
        case IBLOrderActionSend:
        case IBLOrderActionCreate:{
            [self performSegueWithIdentifier:[self segueIdentifierMapForSearch][@(action)] sender:indexPath];
                break;
        }
        case IBLOrderActionDelete:
        case IBLOrderActionTrash:
        case IBLOrderActionFinish:
        case IBLOrderActionHandling:{
            NSString *title = [self.viewModel actionTitleWith:action atIndexPath:indexPath];
            
            UIImage *image = [self.viewModel actionImageWith:action];
            
            NSString *placeholder = [self.viewModel placeHolderWith:action atIndexPath:indexPath];
            
           __block __strong IBLBusinessAlertViewController *alertView = [IBLBusinessAlertViewController alertWithTitle:title
                                                                                           placeholder:placeholder
                                                                                                 image:image];
            @weakify(self)
            alertView.buttonTapped = ^(IBLBusinessAlertViewController *alert, NSInteger buttonIndex){
                @strongify(self)
                [self.viewModel handlerWithAction:action
                                        indexPath:indexPath
                                  completeHandler:^(NSError *error) {
                                      if (![self showAlertWithError:error]) {
                                          [self.tableView.mj_header beginRefreshing];
                                      }
                                  }];
                alertView = nil;
            };
            
            [alertView show];
            break;
        }
        default:break;
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:NavigationToOrderSearchIdentifier]){
        IBLOrderSearchViewController *orderSearchViewController = [segue destinationViewController];
        orderSearchViewController.delegate = self;
        IBLOrderSearchResult *result = [self.viewModel searchResult];
        orderSearchViewController.viewModel = [[IBLOrderSearchViewModel alloc] initWithSearchResult:result];
    }else if ([segue.identifier isEqualToString:OrderActionForwardIdentifier]){
        IBLSearchViewController *forwardSearchViewController = [segue destinationViewController];
        forwardSearchViewController.title = @"转发";
        forwardSearchViewController.viewModel = [IBLOperatorSearchViewModel operatorSearchModelWithOrder:[self.viewModel orderAtIndexPath:sender] searchType:IBLSearchTypeForward];
        forwardSearchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:OrderActionSendIdentifier]){
        IBLSearchViewController *forwardSearchViewController = [segue destinationViewController];
        forwardSearchViewController.title = @"派发";
        forwardSearchViewController.viewModel = [IBLOperatorSearchViewModel operatorSearchModelWithOrder:[self.viewModel orderAtIndexPath:sender] searchType:IBLSearchTypeSend];
        forwardSearchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:NavigationToCreateAccountIdentifier]){
        IBLCreateAccountViewController *createAccountViewController = [segue destinationViewController];
        createAccountViewController.viewModel = [IBLCreateAccountViewModel modelWithCreateAccountType:IBLCreateAccountTypeFromOrder order:[self.viewModel orderAtIndexPath:sender]];
    }
}

- (void)orderSearchViewController:(IBLOrderSearchTableViewController *)searchViewController
                  didSearchResult:(IBLOrderSearchResult *)searchResult {
    [self.viewModel setSearchResult:searchResult];
    [self.tableView.mj_header beginRefreshing];
}

- (void)searchViewController:(IBLSearchViewController *)searchViewController
           didSelectedResult:(id)searchResult {
    IBLOperatorSearchViewModel *forwardViewModel = (IBLOperatorSearchViewModel *)searchViewController.viewModel;
    IBLOperator *operator = searchResult;
    NSString *title = @"";
    NSString *placeholder = @"";
    
    switch (searchViewController.viewModel.searchType) {
        case IBLSearchTypeForward: {
            title = [NSString stringWithFormat:@"转发给：%@", operator.name];
            placeholder = @"转发说明";
            break;
        }
        case IBLSearchTypeSend:{
            title = [NSString stringWithFormat:@"派发给：%@", operator.name];
            placeholder = @"派发说明";
            break;
        }
        default: break;
    }
    
    IBLBusinessAlertViewController *alertView = [IBLBusinessAlertViewController alertWithTitle:title
                                                                                   placeholder:placeholder
                                                                                         image:[UIImage imageNamed:@"alert"]];
    @weakify(self)
    alertView.buttonTapped = ^(IBLBusinessAlertViewController *alert, NSInteger buttonIndex){
        if (buttonIndex == 1) return ;
        @strongify(self)
        [self showHUDWithMessage:@"处理中..."];
        switch (searchViewController.viewModel.searchType) {
            case IBLSearchTypeForward:
            {
                [self.viewModel forwardWithOrder:forwardViewModel.order
                                        operator:operator
                                         content:alert.contentTextField.text
                                 completehandler:^(NSError *error) {
                                     [self hidHUD];
                                     if (![self showAlertWithError:error]) {
                                         [self.tableView.mj_header beginRefreshing];
                                     }
                                 }];
                break;
            }
            case IBLSearchTypeSend:{
                [self.viewModel sendWithOrder:forwardViewModel.order
                                     operator:operator
                                      content:alert.contentTextField.text
                              completehandler:^(NSError *error) {
                                  [self hidHUD];
                                  if (![self showAlertWithError:error]) {
                                      [self.tableView.mj_header beginRefreshing];
                                  }
                              }];
                break;
            }
            default:
                break;
        }
    };
    [alertView show];
}

@end
