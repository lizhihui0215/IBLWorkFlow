//
//  IBLRenewViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRenewViewController.h"
#import "IBLRenewTableViewController.h"

@interface IBLRenewViewController () <IBLRenewTableViewControllerDelegate>

@end

@implementation IBLRenewViewController

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
   IBLRenewTableViewController *renewTableViewController = [segue destinationViewController];
    renewTableViewController.tableViewDelegate = self;
}

- (NSString *)textOfTableViewController:(IBLRenewTableViewController *)controller
                                   type:(IBLRenewTextFieldType)type {
    NSString  *text = @"";
    switch (type) {
        case IBLRenewTextFieldTypeAccount: {
            text = [self.viewModel account];
            break;
        }
        case IBLRenewTextFieldTypeState: {
            text = [self.viewModel state];
            break;
        }
        case IBLRenewTextFieldTypeUsername: {
            text = [self.viewModel username];
            break;
        }
        case IBLRenewTextFieldTypePhone: {
            text = [self.viewModel pbone];
            break;
        }
        case IBLRenewTextFieldTypeRegion: {
            text = [self.viewModel regionName];
            break;
        }
        case IBLRenewTextFieldTypeExpireDate: {
            text = [self.viewModel expireDate];
            break;
        }
        case IBLRenewTextFieldTypeProduct: {
            text = [self.viewModel product];
            break;
        }
        case IBLRenewTextFieldTypeRenewProductCount: {
            text = [self.viewModel renewProductCount];
            break;
        }
        case IBLRenewTextFieldTypeProductPriceAmount: {
            text = [self.viewModel productPriceAmount];
            break;
        }
        case IBLRenewTextFieldTypeProductCount: {
            text = [self.viewModel productCount];
            break;
        }
        case IBLRenewTextFieldTypeTicket: {
            text = [self.viewModel ticket];
            break;
        }
        case IBLRenewTextFieldTypeContract: {
            text = [self.viewModel contract];
            break;
        }
        case IBLRenewTextFieldTypeDiscount: {
            text = [self.viewModel discount];
            break;
        }
        case IBLRenewTextFieldTypeGive: {
            text = [self.viewModel give];
            break;
        }
        case IBLRenewTextFieldTypePay: {
            text = [self.viewModel pay];
            break;
        }
        case IBLRenewTextFieldTypeComment: {
            text = [self.viewModel comment];
            break;
        }
    }
    
    return text;
}

- (void)productPriceOfTableViewController:(IBLRenewTableViewController *)controller
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler {
    NSInteger productId = [[self.viewModel product] integerValue];
    IBLFetchProductPriceInfo *fetchProductPrice = [IBLFetchProductPriceInfo priceWithProductId:productId
                                                                                   discountIds:@""
                                                                                         renew:NO];
    [self showHUDWithMessage:@""];
    [self.viewModel fetchProductPrice:fetchProductPrice
                      completeHandler:^(NSError *error){
                          IBLProductPrice *productPrice = [self.viewModel productPrice];
                          [self hidHUD];
                          [self showAlertWithError:error];
                          completeHandler(productPrice);
                      }];

}

- (void)tableViewController:(IBLRenewTableViewController *)controller
               commitResult:(IBLRenewResult *)result {
    [self.viewModel commitWithResult:result];
}


@end
