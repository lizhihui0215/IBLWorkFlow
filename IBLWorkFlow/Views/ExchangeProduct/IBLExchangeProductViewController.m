//
//  IBLExchangeProductViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductViewController.h"
#import "IBLExchangeProductTableViewController.h"
#import "IBLQRViewController.h"

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

- (void)productPriceOfTableViewController:(IBLExchangeProductTableViewController *)controller
                                  product:(IBLProduct *)product
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler {
    NSInteger productId = product.identifier;
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

- (void)tableViewController:(IBLExchangeProductTableViewController *)controller commitResult:(IBLExchangeProductResult *)result{
    IBLPayModel paymodel = result.pay <= 0 ? IBLPayModelCash : [self.viewModel payModel];
    
    switch (paymodel) {
        case IBLPayModelNet: {
            IBLButtonItem *general = [IBLButtonItem itemWithLabel:@"支付宝支付"
                                                           action:^(IBLButtonItem *item) {
                                                               [self showHUDWithMessage:@""];
                                                               [self.viewModel payWithType:@"1"
                                                                                    result:result
                                                                           completeHandler:^(NSError *error) {
                                                                               [self hidHUD];
                                                                               if (![self showAlertWithError:error]) {
                                                                                   [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLQRPayTypeAilPay)];
                                                                               }
                                                                           }];
                                                           }];
            
            IBLButtonItem *noEmergency = [IBLButtonItem itemWithLabel:@"微信支付"
                                                               action:^(IBLButtonItem *item) {
                                                                   [self showHUDWithMessage:@""];
                                                                   [self.viewModel payWithType:@"0"
                                                                                        result:result
                                                                               completeHandler:^(NSError *error) {
                                                                                   [self hidHUD];
                                                                                   if (![self showAlertWithError:error]) {
                                                                                       [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLQRPayTypeWeChat)];
                                                                                   }
                                                                               }];
                                                               }];
            
            IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
            
            
            IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
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
                                     
                                     NSError *error = [NSError errorWithDomain:@""
                                                                          code:0 userInfo:@{kExceptionCode : @(0),
                                                                                            kExceptionMessage : @"更换成功！"}];
                                     
                                     [self showAlertWithError:error
                                              completeHandler:^(BOOL isShowError, NSError *error) {
                                                  [self.navigationController popToRootViewControllerAnimated:YES];
                                              }];
                                 }
                             }];
            break;
        }
    }    

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
        QRViewController.type = IBLQRTypeFromExchangeProduct;
    }else{
        IBLExchangeProductTableViewController *exchangeProductTableViewController = [segue destinationViewController];
        exchangeProductTableViewController.tableViewDelegate = self;
    }
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
        case IBLExchangeProductTextFieldTypeRegionIdentifier:{
            text = [self.viewModel regionIdentifier];
            break;
        }
        case IBLExchangeProductTextFieldTypeCustType:{
            NSInteger custType = [self.viewModel custType];
            return @(custType);
        }
        case IBLExchangeProductTextFieldTypeEnterpriseName:{
            text = [self.viewModel enterpriseName];
            break;
        }
        case IBLExchangeProductTextFieldTypeEnterpriseContactPhone:{
            text = [self.viewModel enterpriseContactPhone];
            break;
        }
        default: break;
    }
    
    return text;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.viewModel isHiddenAtIndexPath:indexPath];
}


@end
