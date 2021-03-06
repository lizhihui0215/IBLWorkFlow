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
#import "IBLUserRepository.h"

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
    [self showConfirmWithTitle:@"返回将丢失所有填写信息。"
                       message:@""
               completeHandler:^(BOOL isCancel) {
                   if (!isCancel) {
                       [self.navigationController popViewControllerAnimated:YES];
                   }
               }];
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
    
    
    IBLPayModel paymodel = commit.pay <= 0 ? IBLPayModelCash : [self.viewModel payModel];
    if (![IBLUserRepository user].isOnlinePay) {
        [self payWithCash:commit];
        return;
    }
    
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
                                                              createAccountInfo:commit
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
            [self payWithCash:commit];
            break;
        }
    }
}

- (void)payWithCash:(IBLCreateAccountTableViewInfo *)commit{
    [self showHUDWithMessage:@""];
    [self.viewModel createAccountWith:commit completeHandler:^(NSError *error){
        [self hidHUD];
        if (![self showAlertWithError:error]) {
            [self showAlertWithError:errorWithCode(0, @"开户成功")
                     completeHandler:^(BOOL isShowError, NSError * _Nonnull error) {
                         if (self.viewModel.createAccountType == IBLCreateAccountTypeFromOrder) {
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         if([self.delegate respondsToSelector:@selector(createAccountViewController:commit:)]){
                             [self.delegate createAccountViewController:self commit:self.viewModel.order];
                         }
                     }];
        }
    }];
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
        IBLOrderEffectType effType = order.effectType;
        NSString *effDate = order.effectDate;
        if(order.effectType == IBLOrderEffectTypeUnknow) {
            effType = [self.viewModel defaultEffectType];
            effDate = [self.viewModel defaultEffectDate];
        }
        
        createAccountInfo = [IBLCreateAccountTableViewInfo infoWithResidentialIdentifier:order.residentialIdentifier
                                                              productIdentifier:order.productIdentifier
                                                                       username:order.username
                                                                     regionName:order.regionName
                                                                    productName:order.productName
                                                               identifierNumber:order.identifierNumber
                                                                         remark:order.remark
                                                                     effectType:effType
                                                                     effectDate:effDate
                                                                          phone:order.phone
                                                                        address:order.address
                                                                     handleMark:order.handleMark];
        
        createAccountInfo.userType = order.custType;
        createAccountInfo.companyName = order.comName;
        createAccountInfo.companyPhone = order.comContactPhone;
        createAccountInfo.companyAddress = order.comAddr;
        createAccountInfo.companyContact = order.comContact;
        createAccountInfo.simpleComName = order.simpleComName;
        createAccountInfo.certType = order.certType;
        
    }else{
        createAccountInfo = [[IBLCreateAccountTableViewInfo alloc] init];
    }
    
    return createAccountInfo;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
   return [self.viewModel isHiddenAtIndexPath:indexPath];
}




@end
