//
//  IBLOrderViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLOrderViewController.h"
#import "IBLOrderCell.h"
#import "IBLOrderSearchViewController.h"
#import "IBLOrderViewModel.h"
#import "IBLBusinessAlertViewController.h"
#import "IBLSearchViewController.h"
#import "IBLCreateAccountViewController.h"
#import "IBLPayDetailViewController.h"
#import "IBLOrderDetailTableViewController.h"
#import "IBLOrderFlowViewController.h"
#import "IBLUserDetailTableViewController.h"


static NSString *const NavigationToOrderSearchIdentifier = @"NavigationToOrderSearch";

@interface IBLOrderViewController () <IBLOrderSearchDelegate,IBLCreateAccountViewControllerDelegate>

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
    
//    self.viewModel.index = [[self.viewModel statusDictionary] valueForKey:[@(self.status) stringValue]];
    
    [self.viewModel setStatus:self.status];
    
    [self switchTableWithIndex:self.viewModel.index];
    self.segmentedControl.selectedSegmentIndex = self.viewModel.index;
    
    self.segmentedControl.indexChangeBlock = ^(NSInteger index){
        [self switchTableWithIndex:index];
    };
}

- (void)switchTableWithIndex:(NSInteger)index{
    [self.viewModel setIndex:index];
    [self.tableView.mj_header beginRefreshing];
//
//    if([self.viewModel numberOfRowsInSection:0] <= 0){
//    }
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
    [self showHUDWithMessage:@""];
    [self.viewModel fetchOrderListWithIndex:self.segmentedControl.selectedSegmentIndex
                                  isRefresh:NO
                            completeHandler:^(NSError *error) {
                                [self hidHUD];
                                [footer endRefreshing];
                                if (![self showAlertWithError:error]) {
                                    [tableView reloadData];
                                }
                            }];
}

- (void)tableView:(UITableView *)tableView headerBeginRefresh:(MJRefreshStateHeader *)header{
    [self showHUDWithMessage:@""];
    [self.viewModel fetchOrderListWithIndex:self.segmentedControl.selectedSegmentIndex
                                  isRefresh:YES
                            completeHandler:^(NSError *error) {
                                [self hidHUD];
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
    [self performSegueWithIdentifier:@"NavigationToWorkOrderDetail" sender:indexPath];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

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
    IBLOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:MineWorkFlowCellIdentifier forIndexPath:indexPath];
    cell.workOrderTypeLabel.text = [self.viewModel workOrderTypAtIndexPath:indexPath];
    [cell setUserTitle:[self.viewModel usernameAtIndexPath:indexPath]];
    cell.dateLabel.text = [self.viewModel dateAtIndexPath:indexPath];
    [cell setPriority:[self.viewModel orderPriorityAtIndexPath:indexPath]];

    cell.addressLabel.text = [self.viewModel addressAtIndexPath:indexPath];
    NSArray *titles = [self.viewModel orderActionsTitlesAtIndexPath:indexPath];
    [cell setActionTitles:titles];
    cell.workOrderContentLabel.text = [self.viewModel orderContentAtIndexPath:indexPath];
    @weakify(self);
    cell.segmentControl.indexChangeBlock = ^(NSInteger index){
        @strongify(self);
        [self segmentControlTappedWithAction:[self.viewModel actionInIndexPath:indexPath atIndex:index] indexPath:indexPath];
    };
    
    cell.phoneButton.hidden = [self.viewModel isHiddenPhoneAtIndexPath:indexPath];


    [cell.phoneButton addTarget:self
                         action:@selector(phoneButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)phoneButtonPressed:(UIButton *)button{
    CGPoint location = [button.superview convertPoint:button.center toView:self.tableView];

    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    
    NSString *phone = [self.viewModel phoneAtIndexPath:indexPath];
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

- (NSDictionary *)segueIdentifierMapForSearch{
    return @{@(IBLOrderActionForward) : OrderActionForwardIdentifier,
             @(IBLOrderActionSend) : OrderActionSendIdentifier,
             @(IBLOrderActionCreate) : NavigationToCreateAccountIdentifier};
}

- (IBAction)orderCreateAccountFinishedWithSegue:(UIStoryboardSegue *)segue{
    IBLPayDetailViewController *orderDetailViewController = [segue sourceViewController];
    
    NSIndexPath *indexPath = [self.viewModel indexPathWithOrder:orderDetailViewController.order];
    
    [self.viewModel finishedHandleOrderWithAction:IBLOrderActionCreate atIndexPath:indexPath];
    [self.tableView reloadData];
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
            [self showHUDWithMessage:@""];
            NSString *title = [self.viewModel actionTitleWith:action atIndexPath:indexPath];
            
            UIImage *image = [self.viewModel actionImageWith:action];
            
            NSString *placeholder = [self.viewModel placeHolderWith:action atIndexPath:indexPath];
            
           __block IBLBusinessAlertViewController *alertView = [IBLBusinessAlertViewController alertWithTitle:title
                                                                                           placeholder:placeholder
                                                                                                 image:image];
            @weakify(self)
            alertView.buttonTapped = ^(IBLBusinessAlertViewController *alert, NSInteger buttonIndex){
                if (buttonIndex == 1) {[self hidHUD]; [alert close]; return ;}
                if ([NSString isNull:alert.contentTextField.text] && action == IBLOrderActionFinish) {
                    [self hidHUD];
                    NSString *title = NSLocalizedStringFromTable(@"IBLOrderViewController.alert.mustInputContent.title", @"Main", "not found");
                    [UIAlertController showAlertInViewController:self
                                                       withTitle:title
                                                         message:nil
                                               cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:nil];
                    return ;
                }
                [alert close];

                @strongify(self)
                [self.viewModel handlerWithAction:action
                                          content:alert.contentTextField.text
                                        indexPath:indexPath
                                  completeHandler:^(NSError *error) {
                    [self hidHUD];
                    if (![self showAlertWithError:error]) {
                        [self.tableView reloadData];
                    }
                }];
                alertView = nil;
            };
            
            [alertView showInViewController:self.navigationController];
            break;
        }
        case IBLOrderActionView:
        case IBLOrderActionViewSingle:{
            [self performSegueWithIdentifier:@"NavigationToWorkOrderFlow" sender:indexPath];
            break;
        }
    }
    
}

- (void)createAccountViewController:(IBLCreateAccountViewController *)createAccountViewController
                             commit:(IBLOrder *)commit{
    NSIndexPath *indexPath = [self.viewModel indexPathWithOrder:commit];
    [self.viewModel finishedHandleOrderWithAction:IBLOrderActionCreate atIndexPath:indexPath];
    [self.tableView reloadData];
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
        forwardSearchViewController.title = NSLocalizedStringFromTable(@"IBLOrderViewController.controller.title.forward", @"Main", "not found");;
        forwardSearchViewController.viewModel = [IBLOperatorSearchViewModel operatorSearchModelWithOrder:[self.viewModel orderAtIndexPath:sender] searchType:IBLSearchTypeForward];
        forwardSearchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:OrderActionSendIdentifier]){
        IBLSearchViewController *forwardSearchViewController = [segue destinationViewController];
        forwardSearchViewController.title = NSLocalizedStringFromTable(@"IBLOrderViewController.controller.title.send", @"Main", "not found");;
        forwardSearchViewController.viewModel = [IBLOperatorSearchViewModel operatorSearchModelWithOrder:[self.viewModel orderAtIndexPath:sender] searchType:IBLSearchTypeSend];
        forwardSearchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:NavigationToCreateAccountIdentifier]){
        IBLCreateAccountViewController *createAccountViewController = [segue destinationViewController];
        createAccountViewController.viewModel = [IBLCreateAccountViewModel modelWithCreateAccountType:IBLCreateAccountTypeFromOrder order:[self.viewModel orderAtIndexPath:sender]];
        createAccountViewController.delegate = self;
    }else if ([segue.identifier isEqualToString:@"NavigationToWorkOrderDetail"]){
        IBLOrder *order = [self.viewModel orderAtIndexPath:sender];
        IBLOrderDetailTableViewController *orderDetailTableViewController = [segue destinationViewController];
        orderDetailTableViewController.order = order;
    }else if ([segue.identifier isEqualToString:@"NavigationToWorkOrderFlow"]){
        IBLOrderFlowViewController *orderFlowViewController = [segue destinationViewController];
        IBLOrder *order = [self.viewModel orderAtIndexPath:sender];
        orderFlowViewController.viewModel = [[IBLOrderFlowViewModel alloc] initWithOrder:order];
    }else if ([segue.identifier isEqualToString:@"NavigationToUserDetail"]){
        IBLOrder *order = sender;
       IBLUserDetailTableViewController *userDetailViewController = [segue destinationViewController];
        userDetailViewController.order = order;
    }
}

- (IBAction)userOrderTapped:(UIButton *)sender {
    CGPoint location = [sender.superview convertPoint:sender.center toView:self.tableView];

    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    
    
    
    IBLOrder *order = [self.viewModel orderAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"NavigationToUserDetail" sender:order];
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
            title = NSLocalizedStringFromTable(@"IBLOrderViewController.modal.title.forward", @"Main", "not found");
            placeholder = NSLocalizedStringFromTable(@"IBLOrderViewController.modal.placeholder.forward", @"Main", "not found");


            title = [NSString stringWithFormat:@"%@：%@",title, operator.name];
            break;
        }
        case IBLSearchTypeSend:{
            title = NSLocalizedStringFromTable(@"IBLOrderViewController.modal.title.send", @"Main", "not found");
            placeholder = NSLocalizedStringFromTable(@"IBLOrderViewController.modal.placeholder.send", @"Main", "not found");

            title = [NSString stringWithFormat:@"%@：%@", title,operator.name];
            break;
        }
        default: break;
    }
    
    IBLBusinessAlertViewController *alertView = [IBLBusinessAlertViewController alertWithTitle:title
                                                                                   placeholder:placeholder
                                                                                         image:[UIImage imageNamed:@"alert"]];
    @weakify(self)
    alertView.buttonTapped = ^(IBLBusinessAlertViewController *alert, NSInteger buttonIndex){
        if (buttonIndex == 1) {[alert close]; return ;}
        @strongify(self)
        [self showHUDWithMessage:@""];
        switch (searchViewController.viewModel.searchType) {
            case IBLSearchTypeForward:
            {
                [self.viewModel forwardWithOrder:forwardViewModel.order
                                        operator:operator
                                         content:alert.contentTextField.text
                                 completehandler:^(NSError *error) {
                                     if (![self showAlertWithError:error]) {
                                        NSIndexPath *indexPath = [self.viewModel indexPathWithOrder:forwardViewModel.order];
                                         [self.viewModel finishedHandleOrderWithAction:IBLOrderActionForward
                                                                           atIndexPath:indexPath];
                                         [self.tableView reloadData];
                                     }
                                     [self hidHUD];
                                 }];
                break;
            }
            case IBLSearchTypeSend:{
                [self.viewModel sendWithOrder:forwardViewModel.order
                                     operator:operator
                                      content:alert.contentTextField.text
                              completehandler:^(NSError *error) {
                                  if (![self showAlertWithError:error]) {
                                      NSIndexPath *indexPath = [self.viewModel indexPathWithOrder:forwardViewModel.order];
                                      [self.viewModel finishedHandleOrderWithAction:IBLOrderActionSend
                                                                        atIndexPath:indexPath];
                                      [self.tableView reloadData];
                                  }
                                  [self hidHUD];
                              }];
                break;
            }
            default:
                break;
        }
        [alert close];
    };
    [alertView showInViewController:self.navigationController];
}

@end
