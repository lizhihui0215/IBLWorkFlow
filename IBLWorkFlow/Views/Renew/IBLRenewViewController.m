//
//  IBLRenewViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRenewViewController.h"
#import "IBLRenewTableViewController.h"
#import "IBLQRViewController.h"

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
    if ([segue.identifier isEqualToString:@"IBLQRViewController"]) {
        IBLQRViewController *QRViewController = [segue destinationViewController];
        QRViewController.payResult = self.viewModel.payResult;
        QRViewController.pay = [sender integerValue];
        QRViewController.type = IBLQRTypeFromRenew;
    }else{
        IBLRenewTableViewController *renewTableViewController = [segue destinationViewController];
        renewTableViewController.tableViewDelegate = self;
    }
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
    NSInteger productId = [[self.viewModel productIdentifier] integerValue];
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
    
    IBLPayModel model = [self.viewModel payModel];
    
    switch (model) {
        case IBLPayModelNet: {
            IBLButtonItem *general = [IBLButtonItem itemWithLabel:@"支付宝支付"
                                                           action:^(IBLButtonItem *item) {
                                                               [self.viewModel payWithType:@"1"
                                                                                    result:result
                                                                           completeHandler:^(NSError *error) {
                                                                               if (![self showAlertWithError:error]) {
                                                                                   [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLQRPayTypeAilPay)];
                                                                               }
                                                                           }];
                                                           }];
            
            IBLButtonItem *noEmergency = [IBLButtonItem itemWithLabel:@"微信支付"
                                                               action:^(IBLButtonItem *item) {
                                                                   [self.viewModel payWithType:@"0"
                                                                                        result:result
                                                                               completeHandler:^(NSError *error) {
                                                                                   if (![self showAlertWithError:error]) {
                                                                                       [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLQRPayTypeWeChat)];
                                                                                   }
                                                                               }];
                                                               }];
            
            IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
            
            
            IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                            title:@"请选择支付方式"
                                                                          message:nil
                                                                 cancleButtonItem:cancel
                                                                 otherButtonItems:general,noEmergency,nil];
            [alert showInController:self];
            break;
        }
        case IBLPayModelCash: {
            [self.viewModel commitWithResult:result
                             completeHandler:^(NSError *error) {
                if (![self showAlertWithError:error]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
            break;
        }
    }    
}

- (NSDictionary<NSIndexPath *, NSString *> *)notNullsFieldsDictionary {
    return [self.viewModel notNullFieldsDictionary];
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
    return [self.viewModel isHiddenAtIndexPath:indexPath];
}

@end
