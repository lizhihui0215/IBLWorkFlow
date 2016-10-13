//
//  IBLExchangeProductTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductTableViewController.h"
#import "IBLCreateAccountTableViewController.h"
#import "IBLProductPrice.h"
#import "IBLSearchViewController.h"

@interface IBLExchangeProductTableViewController ()<IBLSearchViewControllerDelegate, UITextFieldDelegate>

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
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (nonatomic, strong) IBLExchangeProductResult *result;
@property (weak, nonatomic) IBOutlet UILabel *giveLabel;
@property (nonatomic, strong) IBLProductPrice *productPrice;

@end

@implementation IBLExchangeProductResult


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
    
    NSString *exchangeType = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeExchangeType];
    self.exchangeTypeTextField.text = [self exchangeTypeMap][exchangeType];
    self.renewProductCountTextField.text = @"1";
    self.discountTextField.delegate = self;
    self.payTextField.delegate = self;
    self.giveTextField.delegate = self;
    self.renewProductCountTextField.delegate = self;
    self.giveTextField.text = @"0";
    self.result = [[IBLExchangeProductResult alloc] init];
    self.result.exchangeType = exchangeType;
    self.discountTextField.enabled = NO;
    self.payTextField.enabled = NO;
    self.giveTextField.enabled = NO;
    
}

- (NSDictionary<NSString*, NSString *> *)exchangeTypeMap{
    return @{@"1" : @"立即更换",
             @"3" : @"快带提速"};
}

- (IBAction)productTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"ExchangeProductSearchForProduct" sender:nil];
}


- (IBAction)exchangeTypeTapped:(UITapGestureRecognizer *)sender {
    IBLButtonItem *now = [IBLButtonItem itemWithLabel:@"立即更换"
                                                   action:^(IBLButtonItem *item) {
                                                       self.exchangeTypeTextField.text = @"立即更换";
                                                       self.result.exchangeType = @"1";
                                                   }];
    
    IBLButtonItem *broadband = [IBLButtonItem itemWithLabel:@"宽带提速"
                                                       action:^(IBLButtonItem *item) {
                                                           self.exchangeTypeTextField.text = @"宽带提速";
                                                           self.result.exchangeType = @"3";
                                                       }];
    
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
    
    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                    title:@"请选择生效方式"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                         otherButtonItems:now,broadband,nil];
    [alert showInController:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.discountTextField) {
        [self setupPay];
    }else if (textField == self.payTextField){
        [self setupDiscount];
    }else if (textField == self.giveTextField){
        [self setupSalesCount];
    }else if (textField == self.renewProductCountTextField){
        [self setupRenewProductCount];
    }
}

- (void)setupRenewProductCount{
    [self setupPay];
    [self setupSales];
    [self setupSalesCount];
    [self setupDiscount];
    [self setupGive];
}
- (void)setupPriceWithProductPrice{
    [self setupPay];
    [self setupSales];
    [self setupSalesCount];
    [self setupDiscount];
    [self setupGive];
}

- (CGFloat)pay{
    // 支付金额 = 单个销售品金额（totalFee） ＊ 订购数量 - 优惠金额
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    // 订购数量
    NSInteger count = [self.renewProductCountTextField.text integerValue];
    // 优惠金额
    NSInteger discount = [self.discountTextField.text doubleValue] * 100;
    
    return (unitPrice * count - discount) / 100.0;
}

- (void)setupPay{
    self.payTextField.text = [@([self pay]) stringValue];
}

- (CGFloat)sales{
    // 销售品总金额 = 单个销售品金额（totalFee） ＊ 订购数量
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    
    // 订购数量
    NSInteger count = [self.renewProductCountTextField.text integerValue];
    
    return (unitPrice * count) / 100.0;
}

- (void)setupSales{
    self.productAmountTextField.text = [@([self sales]) stringValue];
}

- (CGFloat)salesCount{
    // 销售品总量 =  单个销售品总周期数(totalLength) * 订购数量 + 临时赠送
    NSInteger totalLength = self.productPrice.totalLength;
    
    // 订购数量
    NSInteger count = [self.renewProductCountTextField.text integerValue];
    
    // 临时赠送
    NSInteger given = [self.giveTextField.text integerValue];
    
    return totalLength * count + given;
}

- (void)setupSalesCount{
    self.productCountLabel.text = [NSString stringWithFormat:@"销售品总量%@",[self unit]];
    self.productCountTextField.text = [@([self salesCount]) stringValue];
}

- (void)setupGive{
    self.giveLabel.text = [NSString stringWithFormat:@"临时赠送%@",[self unit]];
}

- (NSString *)unit{
    NSString *unit = [NSString isNull:self.productPrice.unit] ? @"" : [NSString stringWithFormat:@"(%@)",self.productPrice.unit];
    return unit;
}

- (CGFloat)discount{
    // 优惠金额 = 单个销售品金额（totalFee） ＊ 订购数量 - 支付金额
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    
    // 订购数量
    NSInteger count = [self.renewProductCountTextField.text integerValue];
    
    // 支付金额
    NSInteger pay = [self.payTextField.text doubleValue] * 100;
    
    return (unitPrice * count - pay) / 100.0;
}

- (void)setupDiscount{
    self.discountTextField.text = [@([self discount]) stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveResult{
    self.result.renewProductCount = [self.renewProductCountTextField.text integerValue];
    self.result.productPriceAmount = [self.productAmountTextField.text floatValue];
    self.result.productCount = [self.productCountTextField.text integerValue];
    self.result.ticket = self.ticketTextField.text;
    self.result.contract = self.contractTextField.text;
    self.result.discount = [self.discountTextField.text floatValue];
    self.result.give = [self.giveTextField.text floatValue];
    self.result.pay = [self.payTextField.text floatValue];
    self.result.comment = self.remarkTextView.text;
}

- (IBAction)commitButtonPressed:(UIButton *)sender {
    if([NSString isNull:self.exchangeProductTextField.text]){
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确定"];
        
        
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:@"请选择销售品"
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
        return;
    };
    
    [self saveResult];
    [self.tableViewDelegate tableViewController:self
                                   commitResult:self.result];
}

#pragma mark - Table view data source

- (BOOL)isSeparationAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *separation1 = [NSIndexPath indexPathForRow:7 inSection:0];
    NSIndexPath *separation2 = [NSIndexPath indexPathForRow:10 inSection:0];
    
    NSDictionary *separationDictionary = @{separation1 : @(YES),
                                           separation2 : @(YES)};
    
    return [separationDictionary[indexPath] boolValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self isSeparationAtIndexPath:indexPath]) return 6;
    
    BOOL isHidden = [self.tableViewDelegate isHiddenAtIndexPath:indexPath];
    
    if (isHidden) return 0;

    NSIndexPath *remark = [NSIndexPath indexPathForRow:19 inSection:0];
    
    if ([indexPath isEqual:remark]) return 124;
    
    return 40;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ExchangeProductSearchForProduct"]){
        NSString *regionIdentifier = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeRegionIdentifier];
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        searchViewController.viewModel = [IBLProductSearchViewModel productSearchModelWithSearchType:IBLSearchTypeExchangeProductProduct
                                                                                           productId:0
                                                                                            regionId:[regionIdentifier integerValue]];
        searchViewController.searchDelegate = self;
    }
}

- (void)searchViewController:(IBLSearchViewController *)searchViewController
           didSelectedResult:(id)searchResult {
    switch (searchViewController.viewModel.searchType) {
        case IBLSearchTypeExchangeProductProduct:{
            IBLProduct *product = searchResult;
            self.exchangeProductTextField.text = product.name;
            self.result.product = product;
            self.discountTextField.enabled = YES;
            self.payTextField.enabled = YES;
            self.giveTextField.enabled = YES;
            [self.tableViewDelegate productPriceOfTableViewController:self
                                                              product:product
                                                      completeHandler:^(IBLProductPrice *productPrice) {
                self.productPrice = productPrice;
                [self setupPriceWithProductPrice];
            }];
            break;
        }
            
        default: break;
    }
}
@end
