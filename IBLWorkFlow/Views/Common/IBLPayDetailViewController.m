//
//  IBLPayDetailViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLPayDetailViewController.h"
#import "IBLFetchOrderDetail.h"
#import "IBLHandleOrder.h"

@interface IBLPayDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *payCostTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalLengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalCostTextField;
@property (weak, nonatomic) IBOutlet UITextField *buyLengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *orderNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *orderTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addrTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *offerTextField;
@property (weak, nonatomic) IBOutlet UITextField *nodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *payTypeTextField;
@property (nonatomic, strong) IBLFetchOrderDetail *fetchOrderDetail;

@property (nonatomic, strong) IBLHandleOrder *handleOrder;

@property (nonatomic, strong) IBLOrderDetail *orderDetail;

@end

@implementation IBLPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fetchOrderDetail = [[IBLFetchOrderDetail alloc] init];
    self.handleOrder = [[IBLHandleOrder alloc] init];
    self.payTypeTextField.text = [self payTypeName];
    [self showHUDWithMessage:@""];
    @weakify(self)
    [self.fetchOrderDetail fetchOrderDetailWithOrderNumber:self.orderNumber
                                           completeHandler:^(IBLOrderDetail *orderDetail, NSError *error) {
                                               @strongify(self)
                                               [self hidHUD];
                                               if (orderDetail.servId){
                                                   [self.handleOrder handleOrderWithOrder:self.order
                                                                               markHandle:@"1"
                                                                                   servId:orderDetail.servId
                                                                                  content:@"已开户"
                                                                          completeHandler:^(NSError *error) {
                                                                              
                                                                          }];
                                               }
                                               self.orderDetail = orderDetail;
                                               [self setupUI];
                                           }];
}

- (NSString *)payTypeName{
    return @{@(IBLQRPayDetailTypeAilPay) : @"支付宝",
             @(IBLQRPayDetailTypeWeChat) : @"微信"}[@(self.payModel)];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    switch (self.type) {
        case IBLOrderDetailTypeFromOrderCreateAccount: {
            [self performSegueWithIdentifier:@"NavigationToOrder" sender:nil];
            break;
        }
        case IBLOrderDetailTypeFromCreateAccount: {
            [self performSegueWithIdentifier:@"NavigationToCreateAccount" sender:nil];
            break;
        }
        case IBLOrderDetailTypeFromRenew:{
            [self performSegueWithIdentifier:@"NavigationToRenew" sender:nil];
            break;
        }
        case IBLOrderDetailTypeFromExchangeProduct:{
            [self performSegueWithIdentifier:@"NavigationToExchangeProduct" sender:nil];
            break;
        }
    }
}

- (void)setupUI{
    self.payCostTextField.text = [@(self.orderDetail.payCost / 100.0f) stringValue];
    self.totalLengthTextField.text = [@(self.orderDetail.totalCost / 100.0f) stringValue];
    self.totalLengthTextField.text = self.orderDetail.totalLength;
    self.buyLengthTextField.text = self.orderDetail.buyLength;
    self.orderNoTextField.text = self.orderDetail.orderNo;
    self.orderTypeTextField.text = self.orderDetail.orderType;
    self.addrTextField.text = self.orderDetail.addr;
    self.accountTextField.text = self.orderDetail.account;
    self.passwordTextField.text = self.orderDetail.password;
    self.offerTextField.text = self.orderDetail.offerName;
    self.nodeTextField.text = self.orderDetail.nodeName;
    self.userNameTextField.text = self.orderDetail.userName;
    self.idNoTextField.text = self.orderDetail.idNo;
    self.phoneTextField.text = self.orderDetail.phone;
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
}


@end
