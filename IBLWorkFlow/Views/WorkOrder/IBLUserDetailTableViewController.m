//
//  IBLUserDetailTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserDetailTableViewController.h"
#import "IBLFetchOrderRelatedUser.h"

@interface IBLUserDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *bussinessHallTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *effectDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *expiryDateTextField;
@property (weak, nonatomic) IBOutlet UILabel *backupLabel;
@property (weak, nonatomic) IBOutlet UITextField *userTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyContactPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *certTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifierTextField;
@property (weak, nonatomic) IBOutlet UITextField *companySampleNameTextField;

@property (nonatomic, strong) IBLFetchOrderRelatedUser *fetchOrderRelatedUser;

@property (nonatomic, strong) IBLOrderRelateUser *orderRelateUser;

@end

@implementation IBLUserDetailTableViewController


- (NSDictionary<NSNumber *, NSString *> *)certTypeNames{
    return @{@(0) : @"身份证",
             @(1) : @"驾照",
             @(2) : @"护照",
             @(3) : @"回乡证",
             @(4) : @"台胞证",
             @(5) : @"其它",
             @(6) : @"营业执照",};
}


- (void)setup{
    self.accountTextField.text = self.orderRelateUser.account;
    self.usernameTextField.text = self.orderRelateUser.userName;
    self.passwordTextField.text = self.orderRelateUser.password;
    self.userStateTextField.text = self.orderRelateUser.state;
    self.bussinessHallTextField.text = self.orderRelateUser.bizStation;
    self.regionTextField.text = self.orderRelateUser.areaName;
    self.phoneTextField.text = self.orderRelateUser.phone;
    self.addressTextField.text = self.orderRelateUser.addr;
    self.productTextField.text = self.orderRelateUser.offerName;
    self.effectDateTextField.text = self.orderRelateUser.exfDate;
    self.expiryDateTextField.text = self.orderRelateUser.expDate;
    self.backupLabel.text = self.orderRelateUser.remark;
    self.certTextField.text = [self certTypeNames][@(self.orderRelateUser.certType)];
    self.identifierTextField.text = self.orderRelateUser.idNo;
    self.companySampleNameTextField.text = self.orderRelateUser.sampleComName;
    
    NSString *custName = @"一般用户";
    
    if (self.orderRelateUser.custType == 1) custName = @"企业用户";
    
    self.userTypeTextField.text = custName;
    
    self.companyNameTextField.text = self.orderRelateUser.comName;
    
    self.companyContactTextField.text = self.orderRelateUser.comContact;
    
    self.companyContactPhoneTextField.text = self.orderRelateUser.comContactPhone;
    
    self.companyAddressTextField.text = self.orderRelateUser.comAddr;
    
    [self.tableView reloadData];
    
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderRelateUser.custType == 0) {
        NSIndexPath *companyNameIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
        NSIndexPath *companySampleNameIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];

        NSIndexPath *companyContactIndexPath = [NSIndexPath indexPathForRow:13 inSection:0];
        NSIndexPath *companyContactPhoneIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
        NSIndexPath *companyAddressIndexPath = [NSIndexPath indexPathForRow:15 inSection:0];
        return [@[companyNameIndexPath,
                  companySampleNameIndexPath,
                  companyContactIndexPath,
                  companyContactPhoneIndexPath,
                  companyAddressIndexPath] containsObject:indexPath];

    }else {
        NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
        NSIndexPath *userPhoneIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
        NSIndexPath *userAddressIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
        
        return [@[usernameIndexPath,
                 userPhoneIndexPath,
                  userAddressIndexPath] containsObject:indexPath];

    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 40;
    self.fetchOrderRelatedUser = [[IBLFetchOrderRelatedUser alloc] init];
    [self removeFooterView];
    [self showHUDWithMessage:@""];
    [self.fetchOrderRelatedUser fetchOrderRelatedUserWithID:[@(self.order.userIdentifier) stringValue]
                                                    account:self.order.userAccount
                                            completeHandler:^(IBLOrderRelateUser *relatedUser, NSError *error) {
                                                [self hidHUD];
                                                if (![self showAlertWithError:error]) {
                                                    self.orderRelateUser = relatedUser;
                                                    [self setup];
                                                }
                                            }];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self isHiddenAtIndexPath:indexPath]) return 0;

    UITableViewCell *cell =  [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (size.height < tableView.estimatedRowHeight) {
        return tableView.estimatedRowHeight;
    }
    
    NSLog(@"hight %f",size.height);
    
    return size.height + 0.5;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
