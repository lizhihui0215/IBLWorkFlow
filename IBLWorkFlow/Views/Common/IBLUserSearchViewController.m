//
//  IBLUserSearchViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserSearchViewController.h"
#import "IBLUserSearchTableViewController.h"

@interface IBLUserSearchViewController ()<IBLUserSearchTableViewControllerDelegate>

@end

@implementation IBLUserSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userSearchTableViewController:(IBLUserSearchTableViewController *)tableViewController
                         didEndSearch:(IBLUserSearchResult *)searchResult {

}

- (IBLUserSearchType)userSearchType {
    return self.viewModel.searchType;
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