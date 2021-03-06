//
//  IBLRenewTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRenewTableViewController.h"
#import "IBLProductPrice.h"
#import "IBLCreateAccountTableViewController.h"

@implementation IBLRenewResult
- (instancetype)initWithRenewProductCount:(NSInteger)renewProductCount
                       productPriceAmount:(CGFloat)productPriceAmount
                             productCount:(NSInteger)productCount
                                   ticket:(NSString *)ticket
                                 contract:(NSString *)contract
                                 discount:(CGFloat)discount
                                     give:(CGFloat)give
                                      pay:(CGFloat)pay
                                  comment:(NSString *)comment {
    self = [super init];
    if (self) {
        self.renewProductCount = renewProductCount;
        self.productPriceAmount = productPriceAmount;
        self.productCount = productCount;
        self.ticket = ticket;
        self.contract = contract;
        self.discount = discount;
        self.give = give;
        self.pay = pay;
        self.comment = comment;
    }

    return self;
}

+ (instancetype)resultWithRenewProductCount:(NSInteger)renewProductCount
                         productPriceAmount:(CGFloat)productPriceAmount
                               productCount:(NSInteger)productCount
                                     ticket:(NSString *)ticket
                                   contract:(NSString *)contract
                                   discount:(CGFloat)discount
                                       give:(CGFloat)give
                                        pay:(CGFloat)pay
                                    comment:(NSString *)comment {
    return [[self alloc] initWithRenewProductCount:renewProductCount
                                productPriceAmount:productPriceAmount
                                      productCount:productCount
                                            ticket:ticket
                                          contract:contract
                                          discount:discount
                                              give:give
                                               pay:pay
                                           comment:comment];
}

@end

@interface IBLRenewTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UITextField *expireDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *renewProductCount;
@property (weak, nonatomic) IBOutlet UITextField *productPriceAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *productCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *ticketTextField;
@property (weak, nonatomic) IBOutlet UITextField *contractTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UITextField *giveTextField;
@property (weak, nonatomic) IBOutlet UITextField *payTextField;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *giveLabel;
@property (nonatomic, strong) IBLProductPrice *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *custTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactPhoneTextField;

@end

@implementation IBLRenewTableViewController

- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(0) : @"一般用户",
             @(1) : @"企业用户"};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                              type:IBLRenewTextFieldTypeAccount];
    self.stateTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                            type:IBLRenewTextFieldTypeState];
    self.usernameTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                               type:IBLRenewTextFieldTypeUsername];
    self.phoneTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                            type:IBLRenewTextFieldTypePhone];
    self.regionTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                             type:IBLRenewTextFieldTypeRegion];
    self.expireDateTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                                 type:IBLRenewTextFieldTypeExpireDate];
    self.productTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                              type:IBLRenewTextFieldTypeProduct];
    self.renewProductCount.text = [self.tableViewDelegate textOfTableViewController:self
                                                                               type:IBLRenewTextFieldTypeRenewProductCount];
    self.productPriceAmountTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                                         type:IBLRenewTextFieldTypeProductPriceAmount];
    self.productCountTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                                   type:IBLRenewTextFieldTypeProductCount];
    self.ticketTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                             type:IBLRenewTextFieldTypeTicket];
    self.contractTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                               type:IBLRenewTextFieldTypeContract];
    self.discountTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                               type:IBLRenewTextFieldTypeDiscount];
    self.giveTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                           type:IBLRenewTextFieldTypeGive];
    self.payTextField.text = [self.tableViewDelegate textOfTableViewController:self
                                                                          type:IBLRenewTextFieldTypePay];
    self.commentTextView.text = [self.tableViewDelegate textOfTableViewController:self
                                                                             type:IBLRenewTextFieldTypeComment];

    NSNumber *custType = [self.tableViewDelegate textOfTableViewController:self type:IBLRenewTextFieldTypeCustType] ;

    self.custTypeTextField.text = [self userTypeNames][custType];

    NSString *enterpriseName = [self.tableViewDelegate textOfTableViewController:self type:IBLRenewTextFieldTypeEnterpriseName];

    self.enterpriseNameTextField.text = enterpriseName;

    NSString *enterpriseContactPhone = [self.tableViewDelegate textOfTableViewController:self type:IBLRenewTextFieldTypeEnterpriseContactPhone];

    self.enterpriseContactPhoneTextField.text = enterpriseContactPhone;

    self.commentTextView.textContainerInset = UIEdgeInsetsZero;
    
    self.renewProductCount.text = @"1";
    self.discountTextField.delegate = self;
    self.payTextField.delegate = self;
    self.giveTextField.delegate = self;
    self.renewProductCount.delegate = self;
    self.giveTextField.text = @"";
    
    self.giveTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.renewProductCount.keyboardType = UIKeyboardTypeNumberPad;
    self.discountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.payTextField.keyboardType = UIKeyboardTypeDecimalPad;

    
    [self showHUDWithMessage:@""];
    @weakify(self)
    [self.tableViewDelegate productPriceOfTableViewController:self
                                                completeHandler:^(IBLProductPrice *productPrice) {
                                                    @strongify(self)
                                                    [self hidHUD];
                                                    self.productPrice = productPrice;
                                                    [self setupPriceWithProductPrice];
                                                }];
}



- (BOOL)validateNumberWithText:(NSString *)text{
    if ([NSString isNull:text]) return YES;
    
    NSString *regex = @"^(([1-9]\\d{0,12})|0)(\\.\\d{0,2})?$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isNumber = [predicate evaluateWithObject:text];
    
    if (!isNumber) {
        [self showAlertWithError:errorWithCode(0, @"请输入正确的金额！")];
    }
    
    return isNumber;
}

- (NSArray<UITextField *> *)priceTextFields{
    return @[self.payTextField,
             self.discountTextField,
             self.giveTextField];
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;{
    
    if (textField == self.renewProductCount) {
        
        if ([self.renewProductCount.text integerValue] <= 0) {
            NSError *error = [NSError errorWithDomain:@""
                                                 code:0
                                             userInfo:@{kExceptionCode : @(-1),
                                                        kExceptionMessage: @"订购数量必须大于0！"}];
            [self showAlertWithError:error];
            return NO;

        }
        
        return YES;
    }
    
    BOOL isNumber = [self validateNumberWithText:textField.text];
    if (!isNumber) return NO;
    if (![self validateTextFields:textField]) return NO;
    return YES;

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.discountTextField) {
        [self setupPay];
    }else if (textField == self.payTextField){
        [self setupDiscount];
    }else if (textField == self.giveTextField){
        [self setupSalesCount];
    }else if (textField == self.renewProductCount){
        [self setupProductCount];
    }
}

- (void)setupProductCount{
    self.discountTextField.text = @"";
    self.giveTextField.text = @"";
    [self setupPay];
    [self setupSales];
    [self setupSalesCount];
}

- (void)setupPriceWithProductPrice{
    self.renewProductCount.text = @"1";
    self.discountTextField.text = @"";
    self.giveTextField.text = @"";
    [self setupPay];
    [self setupSales];
    [self setupSalesCount];
    [self setupDiscount];
    [self setupGive];
}

- (CGFloat)payWithDiscount:(CGFloat)aDiscount{
    // 支付金额 = 单个销售品金额（totalFee） ＊ 订购数量 - 优惠金额
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    // 订购数量
    NSInteger count = [self.renewProductCount.text integerValue];
    // 优惠金额
    NSInteger discount = aDiscount * 100;
    
    return (unitPrice * count - discount) / 100.0;
}

- (void)setupPay{
    self.payTextField.text = [@([self payWithDiscount:[self.discountTextField.text doubleValue]]) stringValue];
}
#pragma mark - Table view data source

- (BOOL)isSeparationAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *separation1 = [NSIndexPath indexPathForRow:10 inSection:0];
    
    NSDictionary *separationDictionary = @{separation1 : @(YES),};
    
    return [separationDictionary[indexPath] boolValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self isSeparationAtIndexPath:indexPath]) return 6;
    
    BOOL isHidden = [self.tableViewDelegate isHiddenAtIndexPath:indexPath];
    
    if (isHidden) return 0;
    
    NSIndexPath *remark = [NSIndexPath indexPathForRow:19 inSection:0];
    
    if ([indexPath isEqual:remark]) return 124;
    
    if([self isHiddenAtIndexPath:indexPath]) return 0;
    
    return 40;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)path {
    NSInteger custType = [[self.tableViewDelegate textOfTableViewController:self type:IBLRenewTextFieldTypeCustType] integerValue];

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

- (IBAction)commitButtonPressed:(UIButton *)sender {
    NSDictionary <NSIndexPath *, NSString *> *notNullFields = [self.tableViewDelegate notNullsFieldsDictionary];
    
    NSArray *indexPaths = [notNullFields.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSString *notNullText = nil;
    
    for (NSIndexPath *indexPath in indexPaths) {
        UITextField *textField = [self test][indexPath];
        if([NSString isNull:textField.text]) {
            notNullText = [self notNullTitleDictionary][indexPath];
            break;
        }
    }
    
    if (notNullText) {
        [self showAlertWithError:errorWithCode(0, notNullText)];
    }else{
        IBLRenewResult *result = [IBLRenewResult resultWithRenewProductCount:[self.renewProductCount.text integerValue]
                                                          productPriceAmount:[self sales]
                                                                productCount:[self.productCountTextField.text integerValue]
                                                                      ticket:self.ticketTextField.text
                                                                    contract:self.contractTextField.text
                                                                    discount:[self.discountTextField.text doubleValue]
                                                                        give:[self.giveTextField.text integerValue]
                                                                         pay:[self.payTextField.text doubleValue]
                                                                     comment:self.commentTextView.text];
        
        [self.tableViewDelegate tableViewController:self commitResult:result];
    }
}

- (NSDictionary <NSIndexPath *, NSString *> *)notNullTitleDictionary{
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:0 inSection:3];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:0 inSection:16];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:0 inSection:12];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:0 inSection:11];

    return @{custNameIndexPath : @"用户名不能为空！",
            custPhone : @"联系电话不能为空！",
            custReserve : @"备注不能为空！",
            contractCode : @"合同号不能为空！",
            voiceCode : @"票据号不能为空！",
    };
}

- (NSDictionary <NSIndexPath *, UITextField *> *)test{
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:0 inSection:3];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:0 inSection:16];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:0 inSection:12];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:0 inSection:11];

    return @{custNameIndexPath : self.accountTextField,
            custPhone : self.phoneTextField,
            custReserve : self.commentTextView,
            contractCode : self.contractTextField,
            voiceCode : self.ticketTextField,
    };
}

- (CGFloat)sales{
    // 销售品总金额 = 单个销售品金额（totalFee） ＊ 订购数量
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.totalAmount;
    
    // 订购数量
    NSInteger count = [self.renewProductCount.text integerValue];
    
    return (unitPrice * count) / 100.0;
}

- (void)setupSales{
    self.productPriceAmountTextField.text = [@([self sales]) stringValue];
}

- (CGFloat)salesCount{
    // 销售品总量 =  单个销售品总周期数(totalLength) * 订购数量 + 临时赠送
    NSInteger totalLength = self.productPrice.totalLength;
    
    // 订购数量
    NSInteger count = [self.renewProductCount.text integerValue];
    
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
    NSInteger count = [self.renewProductCount.text integerValue];
    
    // 支付金额
    NSInteger pay = aPay * 100;
    
    return (unitPrice * count - pay) / 100.0;
}

- (void)setupDiscount{
    
    self.discountTextField.text =  [self discountWithPay:[self.payTextField.text doubleValue]] <= 0 ? @"" : [@([self discountWithPay:[self.payTextField.text doubleValue]]) stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
