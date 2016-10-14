//
//  IBLLeftMenuViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLLeftMenuViewController.h"
#import "IBLOrderViewController.h"
#import "UIViewController+RESideMenu.h"
#import "IBLLeftMenuCell.h"
#import "IBLLeftMenuTableHeaderView.h"
#import "IBLLoginViewController.h"
#import "IBLCreateAccountViewController.h"
#import "IBLAddWorkOrderViewController.h"
#import "IBLRenewViewController.h"
#import "IBLExchangeProductViewController.h"
#import "IBLAboutViewController.h"
#import "IBLUserSearchViewController.h"
#import "IBLInternetTableViewController.h"


static NSString *const NavigationToLoginIdentifier = @"NavigationToLogin";

@interface IBLLeftMenuViewController () <IBLLeftMenuTableHeaderViewDelegate,IBLAddWorkOrderViewControllerDelegate, IBLCreateAccountViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@property (nonatomic, strong) NSMutableDictionary *actionViewControllers;

@end

@implementation IBLLeftMenuViewController

- (void)addWorkOrderTableDidCommit:(IBLAddWorkOrderViewController *)addWorkOrderViewController{
    UINavigationController *addWorkOrderNavigationViewController = [self addWorkOrderViewController];
    
    self.actionViewControllers[@(IBLLeftMenuItemActionAddOrder)] = addWorkOrderNavigationViewController;
    
    self.sideMenuViewController.contentViewController = addWorkOrderNavigationViewController;
}

- (void)createAccountViewController:(IBLCreateAccountViewController *)createAccountViewController
                             commit:(IBLOrder *)commit{
    UINavigationController *createAccountNavigationViewController = [self createAccountViewController];
    
    self.actionViewControllers[@(IBLLeftMenuItemActionAddCreateAccount)] = createAccountNavigationViewController;
    
    self.sideMenuViewController.contentViewController = createAccountNavigationViewController;
}

- (void)setupViewControllers{
    UINavigationController *mineOrderContentViewController = [self mineOrderViewController];

    UINavigationController *managedOrderContentViewController = [self managedOrderController];
    
    UINavigationController *createAccountViewController = [self createAccountViewController];
    
    UINavigationController *addWorkOrderViewController = [self addWorkOrderViewController];
    
    UINavigationController *renewViewController = [self renewViewController];
    
    UINavigationController *exchangeProductViewController = [self exchangeProductViewController];
    
    UINavigationController *aboutViewController = [self aboutViewController];
    
    UINavigationController *internetViewController = [self internetViewController];
    
    //FIXME: 添加功能
    self.actionViewControllers = [@{@(IBLLeftMenuSectionActionMineOrder) : mineOrderContentViewController,
                                    @(IBLLeftMenuSectionActionManagedOrder) : managedOrderContentViewController,
                                    @(IBLLeftMenuSectionActionBusinessManaged) : @"",
                                    @(IBLLeftMenuSectionActionAbout) : aboutViewController,
                                    @(IBLLeftMenuItemActionAddOrder) : addWorkOrderViewController,
                                    @(IBLLeftMenuItemActionAddCreateAccount) : createAccountViewController,
                                    @(IBLLeftMenuItemActionAddRenew) : renewViewController,
                                    @(IBLLeftMenuItemActionAddChangeProduct) : exchangeProductViewController,
                                    @(IBLLeftMenuItemActionInternet) : internetViewController} mutableCopy];
}

- (UINavigationController *)internetViewController{
    IBLInternetTableViewController *internetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLInternetTableViewController"];
    
    return [[UINavigationController alloc] initWithRootViewController:internetViewController];
}

- (UINavigationController *)aboutViewController {
   IBLAboutViewController *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLAboutViewController"];
    
    return [[UINavigationController alloc] initWithRootViewController:aboutViewController];
}

- (UINavigationController *)exchangeProductViewController {
    IBLUserSearchViewController *userSearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLUserSearchViewController"];

    userSearchViewController.viewModel = [[IBLUserSearchViewModel alloc] initWithSearchType:IBLUserSearchTypeExchangeProduct];
    
    return [[UINavigationController alloc] initWithRootViewController:userSearchViewController];
}

- (UINavigationController *)renewViewController {
    IBLUserSearchViewController *userSearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLUserSearchViewController"];

    userSearchViewController.viewModel = [[IBLUserSearchViewModel alloc] initWithSearchType:IBLUserSearchTypeRenew];

    return [[UINavigationController alloc] initWithRootViewController:userSearchViewController];
}

- (UINavigationController *)addWorkOrderViewController{
    IBLAddWorkOrderViewController *addWorkOrderController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLAddWorkOrderViewController"];
    
    addWorkOrderController.viewModel = [[IBLAddWorkOrderViewModel alloc] init];
    
    addWorkOrderController.delegate = self;
    
    return [[UINavigationController alloc] initWithRootViewController:addWorkOrderController];
}

- (UINavigationController *)createAccountViewController {
    IBLCreateAccountViewController * createAccountViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLCreateAccountViewController"];
    
    createAccountViewController.viewModel = [IBLCreateAccountViewModel modelWithCreateAccountType:IBLCreateAccountTypeFromLeftMenu order:nil];
    
    createAccountViewController.delegate = self;
    
    return [[UINavigationController alloc] initWithRootViewController:createAccountViewController];
}

- (UINavigationController *)managedOrderController {
    UINavigationController *managedOrderContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    IBLOrderViewController *managedOrderViewController = (IBLOrderViewController *)managedOrderContentViewController.topViewController;
    managedOrderViewController.viewModel = [[IBLOrderViewModel alloc] initWithOrderType:IBLOrderTypeManage];
    return managedOrderContentViewController;
}

- (UINavigationController *)mineOrderViewController {
    UINavigationController *mineOrderContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    IBLOrderViewController *mineOrderViewController = (IBLOrderViewController *)mineOrderContentViewController.topViewController;
    mineOrderViewController.viewModel = [[IBLOrderViewModel alloc] initWithOrderType:IBLOrderTypeMine];
    return mineOrderContentViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:IBLLeftMenuTableHeaderNibName bundle:nil];
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:IBLLeftMenuTableHeaderIdentifier];
    
    self.nameLabel.text = [self.viewModel username];
    
    self.roleLabel.text = [self.viewModel roleOfUser];
    
    [self setupViewControllers];
    
    self.sideMenuViewController.contentViewController = self.actionViewControllers[@(IBLLeftMenuSectionActionMineOrder)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationReviced:)
                                                 name:@"notificationReviced"
                                               object:nil];
}

- (void)notificationReviced:(NSNotification *)notification{
    NSNumber *thePageToOpen = notification.userInfo[@""];
    switch (thePageToOpen.integerValue) {
        case 0:
            
            [self.sideMenuViewController setContentViewController:self.actionViewControllers[@(IBLLeftMenuSectionActionMineOrder)]];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:self.actionViewControllers[@(IBLLeftMenuSectionActionManagedOrder)]];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLSectionItem *item = [self.viewModel sectionItemAtIndexPath:indexPath];
    IBLLeftMenu *menu = item.info;
    self.sideMenuViewController.contentViewController = self.actionViewControllers[@(menu.index)];
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    IBLSection *section = [self.viewModel sectionAt:sectionIndex];
    IBLLeftMenu *menu = section.info;
    
    if (menu.index == 2 || menu.index == 4) {
        return 50;
    }
    
    return 40;

}
- (IBAction)logoutTaped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:NavigationToLoginIdentifier sender:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex{
    IBLLeftMenuTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:IBLLeftMenuTableHeaderIdentifier];
    
    IBLSection *section = [self.viewModel sectionAt:sectionIndex];
    
    IBLLeftMenu *menu = section.info;
    
    header.titleLabel.text = menu.title;
    
    header.sectionIndex = sectionIndex;
    
    header.delegate = self;
    
    if (menu.index == 2 || menu.index == 4) {
        header.topConstraint.constant = 20;
    }
    
    header.iconImageView.image = menu.icon;
    
    return header;
}

- (void)headerView:(IBLLeftMenuTableHeaderView *)headerView tappedAtSection:(NSInteger)sectionIndex {
    IBLSection *section = [self.viewModel sectionAt:sectionIndex];
    IBLLeftMenu *menu = section.info;
    if (menu.index == IBLLeftMenuSectionActionBusinessManaged) return;
    self.sideMenuViewController.contentViewController = self.actionViewControllers[@(menu.index)];
    [self.sideMenuViewController hideMenuViewController];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    return [self.viewModel numberOfRowsInSection:sectionIndex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IBLLeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftMenuCellIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.viewModel titleAtIndexPath:indexPath];;
    cell.iconImageView.image = [self.viewModel imageAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:NavigationToLoginIdentifier]){
        IBLLoginViewController *loginViewController = [segue destinationViewController];

        loginViewController.viewModel = [[IBLLoginViewModel alloc] init];
    }     
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
