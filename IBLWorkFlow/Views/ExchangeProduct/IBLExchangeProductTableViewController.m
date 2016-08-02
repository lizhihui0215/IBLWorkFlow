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
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *renewProductCount;
@property (weak, nonatomic) IBOutlet UITextField *productAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *productCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *contractTextField;
@property (weak, nonatomic) IBOutlet UITextField *tickectTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UITextField *giveTextField;
@property (weak, nonatomic) IBOutlet UITextField *payTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end

@implementation IBLExchangeProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    IBLExchangeProductTextFieldTypeAccount,
//    IBLExchangeProductTextFieldTypeType,
//    IBLExchangeProductTextFieldTypeProduct,
//    IBLExchangeProductTextFieldTypeRenewProductCount,
//    IBLExchangeProductTextFieldTypeProductAmout,
//    IBLExchangeProductTextFieldTypeProductCount,
//    IBLExchangeProductTextFieldTypeContract,
//    IBLExchangeProductTextFieldTypeTicket,
//    IBLExchangeProductTextFieldTypeDiscount,
//    IBLExchangeProductTextFieldTypeGive,
//    IBLExchangeProductTextFieldTypePay,
//    IBLExchangeProductTextFieldTypeRemark,
    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
    self.typeTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeType];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    self.accountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeAccount];
//    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
