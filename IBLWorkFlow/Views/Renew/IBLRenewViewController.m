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

- (id)textOfTableViewController:(IBLRenewTableViewController *)controller
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
        case IBLRenewTextFieldTypeCustType: {
            NSInteger custType = [self.viewModel custType];
            return @(custType);
        }
        case IBLRenewTextFieldTypeEnterpriseContactPhone:{
            text = [self.viewModel enterpriseContactPhone];
            break;
        }
        case IBLRenewTextFieldTypeEnterpriseName: {
            text = [self.viewModel enterpriseName];
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
    
    IBLPayModel paymodel = result.pay <= 0 ? IBLPayModelCash : [self.viewModel payModel];
    
    switch (paymodel) {
        case IBLPayModelNet: {
            [UIAlertController showAlertInViewController:self
                                               withTitle:@"请选择支付方式"
                                                 message:nil
                                       cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@[@"支付宝支付", @"微信支付"]
                                                tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                    NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                                                    NSInteger index = buttonIndex - firstOtherIndex;
                                                    IBLQRPayType payType = index == 0 ? IBLQRPayTypeAilPay : IBLQRPayTypeWeChat;
                                                    NSString *type = index == 0 ? @"1" : @"0";
                                                    [self showHUDWithMessage:@""];
                                                    [self.viewModel payWithType:type
                                                                         result:result
                                                                completeHandler:^(NSError *error) {
                                                                    [self hidHUD];
                                                                    if (![self showAlertWithError:error]) {
                                                                        [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(payType)];
                                                                    }
                                                                }];
                                                    
                                                }];
            break;
        }
        case IBLPayModelCash: {
            [self.viewModel commitWithResult:result
                             completeHandler:^(NSError *error) {
                                 if (![self showAlertWithError:error]) {
                                     [self showAlertWithError:errorWithCode(0, @"续费成功！")
                                              completeHandler:^(BOOL isShowError, NSError * _Nonnull error) {
                                                  [self.navigationController popToRootViewControllerAnimated:YES];
                                              }];
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
