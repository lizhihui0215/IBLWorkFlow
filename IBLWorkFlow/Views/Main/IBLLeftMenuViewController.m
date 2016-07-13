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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@end

@implementation IBLLeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:IBLLeftMenuTableHeaderNibName bundle:nil];
    
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:IBLLeftMenuTableHeaderIdentifier];
    
    self.nameLabel.text = [self.viewModel username];
    
    self.roleLabel.text = [self.viewModel roleOfUser];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex{
    IBLLeftMenuTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:IBLLeftMenuTableHeaderIdentifier];
    
    IBLSection *section = [self.viewModel sectionAt:sectionIndex];
    
    IBLLeftMenu *menu = section.info;
    
    header.titleLabel.text = menu.title;
    
    header.iconImageView.image = menu.icon;
    
    return header;
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

@end
