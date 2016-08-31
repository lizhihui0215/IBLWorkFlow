//
//  IBLOrderDetailViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderDetailViewController.h"
#import "IBLFetchOrderDetail.h"

@interface IBLOrderDetailViewController ()
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

@property (nonatomic, strong) IBLOrderDetail *orderDetail;

@end

@implementation IBLOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fetchOrderDetail = [[IBLFetchOrderDetail alloc] init];
    
    
    @weakify(self)
    [self.fetchOrderDetail fetchOrderDetailWithOrderNumber:self.orderNumber
                                           completeHandler:^(IBLOrderDetail *orderDetail, NSError *error) {
                                               @strongify(self)
                                               self.orderDetail = orderDetail;
                                               [self setupUI];
                                           }];
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
    }
}

- (void)setupUI{
    self.payCostTextField.text = self.orderDetail.payCost;
    self.totalLengthTextField.text = self.orderDetail.totalCost;
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
