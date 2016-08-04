//
//  IBLExchangeProductViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductViewController.h"
#import "IBLExchangeProductTableViewController.h"

@interface IBLExchangeProductViewController () <IBLExchangeProductTableViewControllerDelegate>

@end

@implementation IBLExchangeProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
   IBLExchangeProductTableViewController *exchangeProductTableViewController = [segue destinationViewController];
    exchangeProductTableViewController.tableViewDelegate = self;
}

- (NSString *)exchangeProductText:(IBLExchangeProductTextFieldType)type {
    NSString *text = @"";
    switch (type) {
        case IBLExchangeProductTextFieldTypeAccount: {
            text = [self.viewModel account];
            break;
        }
        case IBLExchangeProductTextFieldTypeStatus: {
            text = [self.viewModel status];
            break;
        }
        case IBLExchangeProductTextFieldTypeUsername: {
            text = [self.viewModel username];
            break;
        }
        case IBLExchangeProductTextFieldTypePhone: {
            text = [self.viewModel phone];
            break;
        }
        case IBLExchangeProductTextFieldTypeRegion: {
            text = [self.viewModel region];
            break;
        }
        case IBLExchangeProductTextFieldTypeFinishedDate: {
            text = [self.viewModel finishedDate];
            break;
        }
        case IBLExchangeProductTextFieldTypeProduct: {
            text = [self.viewModel product];
            break;
        }
        case IBLExchangeProductTextFieldTypeExchangeType: {
            text = [self.viewModel exchangeType];
            break;
        }
        default: break;
    }
    
    
    return text;
}


@end
