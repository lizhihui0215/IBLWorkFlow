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
    }else{
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(backButtonPressed:)];
        
        self.navigationItem.leftBarButtonItem = newBackButton;
    }
}

- (void)backButtonPressed:(UIBarButtonItem *)button{
    IBLButtonItem *confirm = [IBLButtonItem itemWithLabel:@"确认" action:^(IBLButtonItem *item) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                    title:@"返回将丢失所有填写信息。"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                         otherButtonItems:confirm,nil];
    [alert showInController:self];
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
        QRViewController.order = self.viewModel.order;
        switch (self.viewModel.createAccountType) {
            case IBLCreateAccountTypeFromOrder: {
                QRViewController.type = IBLQRTypeFromOrderCreateAccount;
                break;
            }
            case IBLCreateAccountTypeFromLeftMenu: {
                QRViewController.type = IBLQRTypeFromCreateAccount;
                break;
            }
        }
    }
}

- (IBAction)createAccountFinished:(UIStoryboardSegue *)segue{
    [self clean];
}

- (void)clean{
    
}

- (void)tableViewController:(IBLCreateAccountTableViewController *)controller
                     commit:(IBLCreateAccountTableViewInfo *)commit {
    IBLPayModel paymodel = [self.viewModel payModel];
    
    switch (paymodel) {
        case IBLPayModelNet: {
            IBLButtonItem *general = [IBLButtonItem itemWithLabel:@"支付宝支付"
                                                           action:^(IBLButtonItem *item) {
                                                               [self.viewModel payWithType:@"1"
                                                                         createAccountInfo:commit
                                                                           completeHandler:^(NSError *error) {
                                                                               if (![self showAlertWithError:error]) {
                                                                                   [self performSegueWithIdentifier:@"IBLQRViewController" sender:@(IBLQRPayTypeAilPay)];
                                                                               }
                                                               }];
                                                           }];
            
            IBLButtonItem *noEmergency = [IBLButtonItem itemWithLabel:@"微信支付"
                                                               action:^(IBLButtonItem *item) {
                                                                   [self.viewModel payWithType:@"0"
                                                                             createAccountInfo:commit
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
            [self showHUDWithMessage:@""];
            [self.viewModel createAccountWith:commit completeHandler:^(NSError *error){
                [self hidHUD];
                if (![self showAlertWithError:error]) {
                    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确定" action:^(IBLButtonItem *item) {
                        if([self.delegate respondsToSelector:@selector(createAccountViewController:commit:)]){
                            [self.delegate createAccountViewController:self commit:self.viewModel.order];
                        }
                    }];
                    
                    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                                    title:@"开户成功"
                                                                                  message:nil
                                                                         cancleButtonItem:cancel
                                                                         otherButtonItems:nil];
                    [alert showInController:self];
                }
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
