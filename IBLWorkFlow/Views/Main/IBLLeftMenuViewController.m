//
//  IBLLeftMenuViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IBLLeftMenuViewController.h"
#import "IBLMineWorkFlowViewController.h"
#import "IBLWorkFlowManagerViewController.h"
#import "UIViewController+RESideMenu.h"
#import "IBLLeftMenuCell.h"
#import "IBLLeftMenuTableHeaderView.h"

@interface IBLLeftMenuViewController ()

@end

@implementation IBLLeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:IBLLeftMenuTableHeaderNibName bundle:nil];
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:IBLLeftMenuTableHeaderIdentifier];
    
    self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            self.sideMenuViewController.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"secondViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IBLLeftMenuTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:IBLLeftMenuTableHeaderIdentifier];
    
    return header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBLLeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftMenuCellIdentifier forIndexPath:indexPath];
    
    NSArray *titles = @[@"Home", @"Calendar", @"Profile", @"Settings", @"Log Out"];
    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.titleLabel.text = titles[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:images[indexPath.row]];
    return cell;
}

@end
