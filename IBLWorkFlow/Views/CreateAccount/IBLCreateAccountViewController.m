//
//  IBLCreateAccountViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountViewController.h"
#import "IBLCreateAccountTableViewController.h"
#import "IBLQRViewController.h"

static NSString *const IBLCreateAccountEmbedTableViewIdentifier = @"CreateAccountEmbedTableView";

@interface IBLCreateAccountViewController ()

@end

@implementation IBLCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.viewModel.createAccountType == IBLCreateAccountTypeFromLeftMenu) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self action:@selector(presentLeftMenuViewController:)];
    }
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
    if ([segue.identifier isEqualToString:IBLCreateAccountEmbedTableViewIdentifier]) {
        IBLCreateAccountTableViewController *tableViewController = [segue destinationViewController];
        
        tableViewController.tableViewDataSource = self;
    }else if ([segue.identifier isEqualToString:@"IBLQRViewController"]){
        IBLQRViewController *QRViewController = [segue destinationViewController];
        QRViewController.payResult = self.viewModel.payResult;
        QRViewController.pay = [sender integerValue];
    }
}

- (void)tableViewController:(IBLCreateAccountTableViewController *)controller
                     commit:(IBLCreateAccountTableViewInfo *)commit {
    IBLPayModel paymodel = [self.viewModel payModel];
    
    switch (paymodel) {
        case IBLPayModelNet: {
            IBLButtonItem *general = [IBLButtonItem itemWithLabel:@"支付宝支付"
                                                           action:^(IBLButtonItem *item) {
                                                               [self.viewModel payWithType:@"0"
                                                                         createAccountInfo:commit
                                                                           completeHandler:^(NSError *error) {
                                                                               if (![self showAlertWithError:error]) {
                                                                                   [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLPayAilPay)];
                                                                               }
                                                               }];
                                                           }];
            
            IBLButtonItem *noEmergency = [IBLButtonItem itemWithLabel:@"微信支付"
                                                               action:^(IBLButtonItem *item) {
                                                                   [self.viewModel payWithType:@"1"
                                                                             createAccountInfo:commit
                                                                               completeHandler:^(NSError *error) {
                                                                                   if (![self showAlertWithError:error]) {
                                                                                       [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLPayWeChat)];
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
            [self.viewModel createAccountWith:commit completeHandler:^(NSError *error){
                
            }];
            break;
        }
    }
}

- (NSDictionary<NSIndexPath *, NSString *> *)notNullFieldsDictionary;{
    return [self.viewModel notNullFieldsDictionary];
}


- (IBLCreateAccountTableViewInfo *)createAccountInfoOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return [self createAccountInfoFromOrder:self.viewModel.order];
}

- (IBLOrderEffectType)defaultEffectTypeOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return [self.viewModel defaultEffectType];
}

- (IBLCreateAccountType)createAccountTypeOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return self.viewModel.createAccountType;
}

- (NSString *)defaultEffectDateOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return [self.viewModel defaultEffectDate];
}

- (void)productPriceOfTableViewController:(IBLCreateAccountTableViewController *)controller
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler {
    NSInteger productId = controller.createAccountInfo.productIdentifier;
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


- (IBLCreateAccountTableViewInfo *)createAccountInfoFromOrder:(IBLOrder *)order {
    IBLCreateAccountTableViewInfo *createAccountInfo = nil;
    if (order) {
        createAccountInfo = [IBLCreateAccountTableViewInfo infoWithResidentialIdentifier:order.residentialIdentifier
                                                              productIdentifier:order.productIdentifier
                                                                       username:order.username
                                                                     regionName:order.regionName
                                                                    productName:order.productName
                                                               identifierNumber:order.identifierNumber
                                                                         remark:order.remark
                                                                     effectType:order.effectType
                                                                     effectDate:order.effectDate
                                                                          phone:order.phone
                                                                        address:order.address
                                                                     handleMark:order.handleMark];
    }else{
        createAccountInfo = [[IBLCreateAccountTableViewInfo alloc] init];
    }
    
    return createAccountInfo;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
   return [self.viewModel isHiddenAtIndexPath:indexPath];
}




@end
