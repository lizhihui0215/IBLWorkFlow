//
//  IBLOrderSearchViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewController.h"
#import "IBLMineOrderViewController.h"


@implementation IBLOrderSearchViewController

- (IBAction)searchButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(orderSearchViewController:didSearchResult:)]) {
        [self.delegate orderSearchViewController:self didSearchResult:self.viewModel.searchResult];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
