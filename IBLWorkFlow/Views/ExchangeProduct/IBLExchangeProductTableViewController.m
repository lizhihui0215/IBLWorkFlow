//
//  IBLExchangeProductTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductTableViewController.h"

@interface IBLExchangeProductTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *statusTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UITextField *finishedDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *exchangeTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *exchangeProductTextField;
@property (weak, nonatomic) IBOutlet UITextField *productAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *productCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *contractTextField;
@property (weak, nonatomic) IBOutlet UITextField *ticketTextField;
@property (weak, nonatomic) IBOutlet UITextField *renewProductCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UITextField *giveTextField;
@property (weak, nonatomic) IBOutlet UITextField *payTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end

@implementation IBLExchangeProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
    self.statusTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeStatus];
    self.usernameTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeUsername];
    self.phoneTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypePhone];
    self.regionTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeRegion];
    self.finishedDateTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeFinishedDate];
    self.productTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeProduct];
    self.exchangeTypeTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeExchangeType];
    self.exchangeProductTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeExchangeProduct];
    self.productAmountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeProductAmount];
    self.productCountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeProductCount];
    self.contractTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeContract];
    self.ticketTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeTicket];
    self.renewProductCountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeRenewProductCount];
    self.discountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeDiscount];
    self.giveTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeGive];
    self.giveTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeGive];
    self.payTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypePay];
    self.remarkTextView.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeRemark];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
    
    
//    124
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
