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

@property (nonatomic, strong) IBLFetchOrderRelatedUser *fetchOrderRelatedUser;

@property (nonatomic, strong) IBLOrderRelateUser *orderRelateUser;

@end

@implementation IBLUserDetailTableViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fetchOrderRelatedUser = [[IBLFetchOrderRelatedUser alloc] init];
    
    [self.fetchOrderRelatedUser fetchOrderRelatedUserWithID:[@(self.order.userIdentifier) stringValue]
                                                    account:self.order.userAccount
                                            completeHandler:^(IBLOrderRelateUser *relatedUser, NSError *error) {
                                                self.orderRelateUser = relatedUser;
                                                [self setup];
                                            }];
    
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = view;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
