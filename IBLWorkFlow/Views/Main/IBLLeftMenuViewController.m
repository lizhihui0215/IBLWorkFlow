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


static NSString *const NavigationToLoginIdentifier = @"NavigationToLogin";

@interface IBLLeftMenuViewController () <IBLLeftMenuTableHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@property (nonatomic, strong) NSDictionary *viewControllers;

@end

@implementation IBLLeftMenuViewController

- (void)setupViewControllers{
    UINavigationController *mineOrderContentViewController = [self mineOrderViewController];

    UINavigationController *managedOrderContentViewController = [self managedOrderController];
    
    UINavigationController *createAccountViewController = [self createAccountViewController];
    
    UINavigationController *addWorkOrderViewController = [self addWorkOrderViewController];
    
    UINavigationController *renewViewController = [self renewViewController];
    
    UINavigationController *exchangeProductViewController = [self exchangeProductViewController];
    
    UINavigationController *aboutViewController = [self aboutViewController];
    
    //FIXME: 添加功能
    self.viewControllers = @{@(IBLLeftMenuSectionActionMineOrder) : mineOrderContentViewController,
                             @(IBLLeftMenuSectionActionManagedOrder) : managedOrderContentViewController,
                             @(IBLLeftMenuSectionActionBusinessManaged) : @"",
                             @(IBLLeftMenuSectionActionAbout) : aboutViewController,
                             @(IBLLeftMenuItemActionAddOrder) : addWorkOrderViewController,
                             @(IBLLeftMenuItemActionAddCreateAccount) : createAccountViewController,
                             @(IBLLeftMenuItemActionAddRenew) : renewViewController,
                             @(IBLLeftMenuItemActionAddChangeProduct) : exchangeProductViewController,};
}

- (UINavigationController *)aboutViewController {
   IBLAboutViewController *aboutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLAboutViewController"];
    
    return [[UINavigationController alloc] initWithRootViewController:aboutViewController];
}

- (UINavigationController *)exchangeProductViewController {
    IBLExchangeProductViewController *exchangeProductViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLExchangeProductViewController"];

    
    return [[UINavigationController alloc] initWithRootViewController:exchangeProductViewController];
}

- (UINavigationController *)renewViewController {
    IBLRenewViewController *renewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLRenewViewController"];

    
    return [[UINavigationController alloc] initWithRootViewController:renewViewController];
}

- (UINavigationController *)addWorkOrderViewController{
    IBLAddWorkOrderViewController *addWorkOrderController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLAddWorkOrderViewController"];
    
    return [[UINavigationController alloc] initWithRootViewController:addWorkOrderController];
}

- (UINavigationController *)createAccountViewController {
    IBLCreateAccountViewController * createAccountViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"IBLCreateAccountViewController"];
    
    createAccountViewController.viewModel = [IBLCreateAccountViewModel modelWithCreateAccountType:IBLCreateAccountTypeFromLeftMenu order:nil];
    
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
    
    self.sideMenuViewController.contentViewController = self.viewControllers[@(IBLLeftMenuSectionActionMineOrder)];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLSectionItem *item = [self.viewModel sectionItemAtIndexPath:indexPath];
    IBLLeftMenu *menu = item.info;
    self.sideMenuViewController.contentViewController = self.viewControllers[@(menu.index)];
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
    self.sideMenuViewController.contentViewController = self.viewControllers[@(menu.index)];
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




@end
