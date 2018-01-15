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
@property (weak, nonatomic) IBOutlet UITextField *exchangeCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UITextField *giveTextField;
@property (weak, nonatomic) IBOutlet UITextField *payTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (nonatomic, strong) IBLExchangeProductResult *result;
@property (weak, nonatomic) IBOutlet UILabel *giveLabel;
@property (nonatomic, strong) IBLProductPrice *productPrice;
@property (weak, nonatomic) IBOutlet UITextField *custTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactPhoneTextField;

@end

@implementation IBLExchangeProductResult


@end

@implementation IBLExchangeProductTableViewController


- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(0) : @"一般用户",
            @(1) : @"企业用户"};
}

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
    self.exchangeCountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeRenewProductCount];
    self.discountTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeDiscount];
    self.giveTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeGive];
    self.giveTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeGive];
    self.payTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypePay];
    self.remarkTextView.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeRemark];

    NSString *custType = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeCustType];
    
    self.custTypeTextField.text = [self userTypeNames][@([custType integerValue])];

    self.enterpriseContactPhoneTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeEnterpriseContactPhone];

    self.enterpriseNameTextField.text = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeEnterpriseName];

    
    NSString *exchangeType = [self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeExchangeType];
    self.exchangeTypeTextField.text = [self exchangeTypeMap][exchangeType];
    self.exchangeCountTextField.text = @"1";
    self.discountTextField.delegate = self;
    self.payTextField.delegate = self;
    self.giveTextField.delegate = self;
    self.exchangeCountTextField.delegate = self;
    self.result = [[IBLExchangeProductResult alloc] init];
    self.result.exchangeType = exchangeType;
    self.discountTextField.enabled = NO;
    self.payTextField.enabled = NO;
    self.giveTextField.enabled = NO;
    self.giveTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.exchangeCountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.payTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.discountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self setPriceTextFieldsEnable:NO];
}

- (NSDictionary<NSString*, NSString *> *)exchangeTypeMap{
    return @{@"1" : @"立即更换",
             @"3" : @"快带提速"};
}

- (IBAction)productTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"ExchangeProductSearchForProduct" sender:nil];
}


- (IBAction)exchangeTypeTapped:(UITapGestureRecognizer *)sender {
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择证件号码"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"身份证", @"驾照", @"护照", @"回乡证", @"台胞证", @"其它", @"营业执照"]
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
                        
                    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        if (buttonIndex == [controller cancelButtonIndex]) return;
                        
                        NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                        NSInteger index = buttonIndex - firstOtherIndex;
                        if (index == 0) {
                            self.exchangeTypeTextField.text = @"立即更换";
                            self.result.exchangeType = @"1";
                        }else if (index == 1) {
                            self.exchangeTypeTextField.text = @"宽带提速";
                            self.result.exchangeType = @"3";
                        }
                    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.discountTextField) {
        [self setupPay];
    }else if (textField == self.payTextField){
        [self setupDiscount];
    }else if (textField == self.giveTextField){
        [self setupSalesCount];
    }else if (textField == self.exchangeCountTextField){
        [self setupRenewProductCount];
    }
}

- (void)setupRenewProductCount{
    self.discountTextField.text = @"";
    self.giveTextField.text = @"";
    [self setupPay];
    [self setupSales];
    [self setupSalesCount];
}
- (void)setupPriceWithProductPrice{
    self.exchangeCountTextField.text = @"1";
    self.discountTextField.text = @"";
    self.giveTextField.text = @"";
    [self setupPay];
    [self setupSales];
    [self setupSalesCount];
    [self setupDiscount];
    [self setupGive];
    [self setPriceTextFieldsEnable:YES];
}

- (CGFloat)payWithDiscount:(CGFloat)aDiscount{
    // 支付金额 = 单个销售品金额（totalFee） ＊ 订购数量 - 优惠金额
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    // 订购数量
    NSInteger count = [self.exchangeCountTextField.text integerValue];
    // 优惠金额
    NSInteger discount = aDiscount * 100;
    
    return (unitPrice * count - discount) / 100.0;
}

- (void)setupPay{
    self.payTextField.text = [@([self payWithDiscount:[self.discountTextField.text doubleValue]]) stringValue];
}

- (CGFloat)sales{
    // 销售品总金额 = 单个销售品金额（totalFee） ＊ 订购数量
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    
    // 订购数量
    NSInteger count = [self.exchangeCountTextField.text integerValue];
    
    return (unitPrice * count) / 100.0;
}

- (void)setupSales{
    self.productAmountTextField.text = [@([self sales]) stringValue];
}

- (CGFloat)salesCount{
    // 销售品总量 =  单个销售品总周期数(totalLength) * 订购数量 + 临时赠送
    NSInteger totalLength = self.productPrice.totalLength;
    
    // 订购数量
    NSInteger count = [self.exchangeCountTextField.text integerValue];
    
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

- (CGFloat)discountWithPay:(CGFloat)aPay{
    // 优惠金额 = 单个销售品金额（totalFee） ＊ 订购数量 - 支付金额
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    
    // 订购数量
    NSInteger count = [self.exchangeCountTextField.text integerValue];
    
    // 支付金额
    NSInteger pay = aPay * 100;
    
    return (unitPrice * count - pay) / 100.0;
}

- (void)setupDiscount{
    self.discountTextField.text = [self discountWithPay:[self.payTextField.text doubleValue]] <= 0 ? @"" : [@([self discountWithPay:[self.payTextField.text doubleValue]]) stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveResult{
    self.result.renewProductCount = [self.exchangeCountTextField.text integerValue];
    self.result.productPriceAmount = [self sales];
    self.result.productCount = [self.productCountTextField.text integerValue];
    self.result.ticket = self.ticketTextField.text;
    self.result.contract = self.contractTextField.text;
    self.result.discount = [self.discountTextField.text doubleValue];
    self.result.give = [self.giveTextField.text integerValue];
    self.result.pay = [self.payTextField.text doubleValue];
    self.result.comment = self.remarkTextView.text;
}

- (IBAction)commitButtonPressed:(UIButton *)sender {
    if([NSString isNull:self.exchangeProductTextField.text]){
        [self showAlertWithError:errorWithCode(0, @"请选择销售品")];
        return;
    };
    
    [self saveResult];
    [self.tableViewDelegate tableViewController:self
                                   commitResult:self.result];
}

- (void)setPriceTextFieldsEnable:(BOOL)enable{
    NSString *placeholder = enable ? @"请输入" : @"请选择销售品";
    
    for (UITextField *textField in [self priceTextFields]) {
        textField.placeholder = placeholder;
        textField.enabled = enable;
    }
    
    self.exchangeCountTextField.enabled = enable;
    self.exchangeCountTextField.placeholder = placeholder;
}


#pragma mark - Table view data source

- (BOOL)isSeparationAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *separation1 = [NSIndexPath indexPathForRow:10 inSection:0];
    NSIndexPath *separation2 = [NSIndexPath indexPathForRow:13 inSection:0];
    
    NSDictionary *separationDictionary = @{separation1 : @(YES),
                                           separation2 : @(YES)};
    
    return [separationDictionary[indexPath] boolValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self isSeparationAtIndexPath:indexPath]) return 6;
    
    BOOL isHidden = [self.tableViewDelegate isHiddenAtIndexPath:indexPath];
    
    if (isHidden) return 0;

    NSIndexPath *remark = [NSIndexPath indexPathForRow:22 inSection:0];
    
    if ([indexPath isEqual:remark]) return 124;
    
    if([self isHiddenAtIndexPath:indexPath]) return 0;
    
    return 40;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)path {
    NSInteger custType = [[self.tableViewDelegate exchangeProductText:IBLExchangeProductTextFieldTypeCustType] integerValue];
    
    NSMutableArray *hiddenIndexPaths = [NSMutableArray array];
    
    if (custType == 0){
        NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        NSIndexPath *enterpriseContactPhoneIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        [hiddenIndexPaths addObject:enterpriseNameIndexPath];
        [hiddenIndexPaths addObject:enterpriseContactPhoneIndexPath];
    } else{
        NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        NSIndexPath *custPhoneIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        
        [hiddenIndexPaths addObject:custNameIndexPath];
        [hiddenIndexPaths addObject:custPhoneIndexPath];
    }
    
    
    return [hiddenIndexPaths containsObject:path];
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

- (BOOL)validateTextFields:(UITextField *)textField{
    
    BOOL isValidate = YES;
    
    NSString *title = @"";
    
    // 支付金额
    CGFloat pay = 0;
    // 销售品总金额
    CGFloat sales = [self sales];
    
    CGFloat discount = 0;

    // 优惠金额
    

    
    if (textField == self.payTextField){
        pay = [textField.text doubleValue];
        discount = [self discountWithPay:pay];
        if (pay < 0) {
            title = @"支付金额必须大于0";
            isValidate = NO;
        }
        
        if (pay > sales) {
            title = @"支付金额必须小于总金额";
            isValidate = NO;
        }
        
    }

    if (textField == self.discountTextField) {
        discount = [textField.text doubleValue];
        pay = [self payWithDiscount:discount];

        
        if (sales < discount) {
            title = @"优惠金额必须小于总金额";
            isValidate = NO;
        }

        
        if ([textField.text doubleValue] < 0) {
            title = @"优惠金额必须大于0";
            isValidate = NO;
        }
        
    }

    if (!isValidate) {
        [self showAlertWithError:errorWithCode(0, title)];
    }
    
    return  isValidate;
}

- (BOOL)validateNumberWithText:(NSString *)text{
    if ([NSString isNull:text]) return YES;
    
    NSString *regex = @"^(([1-9]\\d{0,12})|0)(\\.\\d{0,2})?$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isNumber = [predicate evaluateWithObject:text];
    
    if (!isNumber) {
        [self showAlertWithError:errorWithCode(0, @"请输入大于0的数字！")];
    }
    
    return isNumber;
}


- (BOOL)validatePriceWithTextField:(UITextField *)textField{
    
    BOOL isNumber = [self validateNumberWithText:textField.text];
    
    if (!isNumber) return NO;
    
    if (![self validateTextFields:textField]) return NO;
    
    return YES;
}

- (NSArray<UITextField *> *)priceTextFields{
    return @[self.payTextField,
             self.discountTextField,
             self.giveTextField];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.exchangeCountTextField) {
        if ([self.exchangeCountTextField.text integerValue] <= 0) {
            NSError *error = [NSError errorWithDomain:@""
                                                 code:0
                                             userInfo:@{kExceptionCode : @(-1),
                                                        kExceptionMessage: @"订购数量必须大于0！"}];
            [self showAlertWithError:error];
            return NO;
        }
        
        return YES;
    }

    
    if ([[self priceTextFields] containsObject:textField]) return [self validatePriceWithTextField:textField];
    

    return YES;
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
