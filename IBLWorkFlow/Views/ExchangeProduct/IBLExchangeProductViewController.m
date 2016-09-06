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

- (void)tableViewController:(IBLExchangeProductTableViewController *)controller commitResult:(IBLExchangeProductResult *)result{
    IBLPayModel model = [self.viewModel payModel];
    
    switch (model) {
        case IBLPayModelNet: {
            IBLButtonItem *general = [IBLButtonItem itemWithLabel:@"支付宝支付"
                                                           action:^(IBLButtonItem *item) {
                                                               [self.viewModel payWithType:@"0"
                                                                                    result:result
                                                                           completeHandler:^(NSError *error) {
                                                                               if (![self showAlertWithError:error]) {
                                                                                   [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLQRPayTypeAilPay)];
                                                                               }
                                                                           }];
                                                           }];
            
            IBLButtonItem *noEmergency = [IBLButtonItem itemWithLabel:@"微信支付"
                                                               action:^(IBLButtonItem *item) {
                                                                   [self.viewModel payWithType:@"1"
                                                                                        result:result
                                                                               completeHandler:^(NSError *error) {
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
                                     [self.navigationController popToRootViewControllerAnimated:YES];
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
        case IBLExchangeProductTextFieldTypeRegionIdentifier:{
            text = [self.viewModel regionIdentifier];
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
