//
//  IBLPayDetailViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLStaticTableViewController.h"
#import "IBLPayDetailViewController.h"
#import "IBLFetchOrderDetail.h"
#import "IBLHandleOrder.h"
#import "IBLOrderDetail.h"
#import "IBLAppRepository.h"

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
@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseSampleNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *certTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *custTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *payTypeTextField;
@property (nonatomic, strong) IBLFetchOrderDetail *fetchOrderDetail;

@property (nonatomic, strong) IBLHandleOrder *handleOrder;

@property (nonatomic, strong) IBLOrderDetail *orderDetail;

@end

@implementation IBLPayDetailViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self isHiddenAtIndexPath:indexPath]) return 0;
    
    if ([self isSepectorAtIndexPath:indexPath]) return 6;
    
    return 40;
}

- (BOOL)isSepectorAtIndexPath:(NSIndexPath *)path {
    NSIndexPath *sepctorIndexPath1 = [NSIndexPath indexPathForRow:3 inSection:0];
    NSIndexPath *sepctorIndexPath2 = [NSIndexPath indexPathForRow:19 inSection:0];
    return [@[sepctorIndexPath1,sepctorIndexPath2] containsObject:path];
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)path {
    NSMutableArray *hiddenIndexPaths = [NSMutableArray array];
    
    if (self.orderDetail.custType == 0) {
        NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
        NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:15 inSection:0];
        NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:16 inSection:0];
        NSIndexPath *enterpriseContactPhoneIndexPath = [NSIndexPath indexPathForRow:17 inSection:0];
        NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:18 inSection:0];
        [hiddenIndexPaths addObject:enterpriseNameIndexPath];
        [hiddenIndexPaths addObject:enterpriseSampleNameIndexPath];
        [hiddenIndexPaths addObject:enterpriseContactIndexPath];
        [hiddenIndexPaths addObject:enterpriseContactPhoneIndexPath];
        [hiddenIndexPaths addObject:enterpriseAddressIndexPath];
    }else {
        NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
        NSIndexPath *userPhoneIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
        NSIndexPath *userAddressIndexPath = [NSIndexPath indexPathForRow:13 inSection:0];
        [hiddenIndexPaths addObject:usernameIndexPath];
        [hiddenIndexPaths addObject:userPhoneIndexPath];
        [hiddenIndexPaths addObject:userAddressIndexPath];
    }
    
    if ([IBLAppRepository appConfiguration].showCustType == 0){
        NSIndexPath *custTypeIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        [hiddenIndexPaths addObject:custTypeIndexPath];
    }
    
    
    return [hiddenIndexPaths containsObject:path];
}

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
    self.totalCostTextField.text = [@(self.orderDetail.totalCost / 100.0f) stringValue];
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
    
    self.enterpriseNameTextField.text = self.orderDetail.comName;
    self.enterpriseContactTextField.text = self.orderDetail.comContact;
    self.enterpriseContactPhoneTextField.text = self.orderDetail.comContactPhone;
    self.enterpriseSampleNameTextField.text = self.orderDetail.simpleComName;
    self.enterpriseAddressTextField.text = self.orderDetail.comAddr;
    
    self.custTypeTextField.text = [self userTypeNames][@(self.orderDetail.custType)];
    self.certTypeTextField.text = [self certTypeNames][@(self.orderDetail.certType)];
    [self.tableView reloadData];
}

- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(0) : @"一般用户",
             @(1) : @"企业用户"};
}

- (NSDictionary<NSNumber *, NSString *> *)certTypeNames{
    return @{@(0) : @"身份证",
             @(1) : @"驾照",
             @(2) : @"护照",
             @(3) : @"回乡证",
             @(4) : @"台胞证",
             @(5) : @"其它",
             @(6) : @"营业执照",};
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
