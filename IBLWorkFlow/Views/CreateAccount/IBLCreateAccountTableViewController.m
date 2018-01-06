//
//  IBLCreateAccountTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountTableViewController.h"
#import "IBLSectionHeaderView.h"
#import "IBLSearchViewController.h"
#import "HcdDateTimePickerView.h"
#import "IBLAppRepository.h"

@implementation IBLCreateAccountTableViewInfo

- (instancetype)initWithResidentialIdentifier:(NSInteger)residentialIdentifier
                            productIdentifier:(NSInteger)productIdentifier
                                     username:(NSString *)username
                                   regionName:(NSString *)regionName
                                  productName:(NSString *)productName
                             identifierNumber:(NSString *)identifierNumber
                                       remark:(NSString *)remark
                                   effectType:(IBLOrderEffectType)effectType
                                   effectDate:(NSString *)effectDate
                                        phone:(NSString *)phone
                                      address:(NSString *)address
                                   handleMark:(NSString *)handleMark {
    self = [super init];
    if (self) {
        self.residentialIdentifier = residentialIdentifier;
        self.productIdentifier = productIdentifier;
        self.username = username;
        self.regionName = regionName;
        self.productName = productName;
        self.identifierNumber = identifierNumber;
        self.remark = remark;
        self.effectType = effectType;
        self.effectDate = effectDate;
        self.phone = phone;
        self.address = address;
        self.handleMark = handleMark;
    }
    
    return self;
}

+ (instancetype)infoWithResidentialIdentifier:(NSInteger)residentialIdentifier
                            productIdentifier:(NSInteger)productIdentifier
                                     username:(NSString *)username
                                   regionName:(NSString *)regionName
                                  productName:(NSString *)productName
                             identifierNumber:(NSString *)identifierNumber
                                       remark:(NSString *)remark
                                   effectType:(IBLOrderEffectType)effectType
                                   effectDate:(NSString *)effectDate
                                        phone:(NSString *)phone
                                      address:(NSString *)address
                                   handleMark:(NSString *)handleMark {
    return [[self alloc] initWithResidentialIdentifier:residentialIdentifier
                                     productIdentifier:productIdentifier
                                              username:username
                                            regionName:regionName
                                           productName:productName
                                      identifierNumber:identifierNumber
                                                remark:remark
                                            effectType:effectType
                                            effectDate:effectDate
                                                 phone:phone
                                               address:address
                                            handleMark:handleMark];
}

@end

@interface IBLCreateAccountTableViewController ()<IBLSearchViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong, readwrite) IBLCreateAccountTableViewInfo *createAccountInfo;

/// 用户账号
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
/// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
/// 所属区域
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
/// 销售品
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
/// 订购数量
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
/// 生效方式
@property (weak, nonatomic) IBOutlet UITextField *methodOfValidTextField;
/// 生效日期
@property (weak, nonatomic) IBOutlet UITextField *dateOfValidTextField;
/// 开户姓名
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
/// 联系电话
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
/// 联系地址
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
/// 身份证号
@property (weak, nonatomic) IBOutlet UITextField *identifierTextField;
/// 备注
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
/// 销售品总额
@property (weak, nonatomic) IBOutlet UITextField *salesTextField;
/// 销售品总量
@property (weak, nonatomic) IBOutlet UITextField *salesCountTextField;
/// 合同号
@property (weak, nonatomic) IBOutlet UITextField *contractNumberTextField;
/// 票据号
@property (weak, nonatomic) IBOutlet UITextField *ticketNumberTextField;
/// 临时赠送
@property (weak, nonatomic) IBOutlet UITextField *giveTextField;
/// 优惠金额
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UITextField *userTypeTextField;
/// 支付金额
@property (weak, nonatomic) IBOutlet UITextField *payTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifierTypeTextField;

@property (nonatomic, strong) IBLProductPrice *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *giveLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterprisesContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterprisesPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterprisesAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterprisesSampleNameTextField;


@end

@implementation IBLCreateAccountTableViewController
- (IBAction)effectDateTapped:(UITapGestureRecognizer *)sender {
    
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datePicker.formatter = formatter;
    [datePicker showHcdDateTimePicker];
    datePicker.clickedOkBtn = ^(NSString *time){
        self.createAccountInfo.effectDate = time;
        self.dateOfValidTextField.text = self.createAccountInfo.effectDate;
    };
}
- (IBAction)identifierTypeTapped:(UITapGestureRecognizer *)sender {
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择证件号码"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"身份证", @"驾照", @"护照", @"回乡证", @"台胞证", @"其它", @"营业执照"]
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
                        
                    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                        NSInteger index = buttonIndex - firstOtherIndex;
                        self.createAccountInfo.certType = index;
                        self.identifierTypeTextField.text = [self certTypeNames][@(self.createAccountInfo.certType)];
                        [self.tableView reloadData];
                    }];
}

- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(IBLCreateAccountUserTypeDetault) : @"一般用户",
             @(IBCreateAccountLUserTypeEnterprise) : @"企业用户"};
}

- (IBAction)userTypeTapped:(UITapGestureRecognizer *)sender { 
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择用户类型"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"一般用户", @"企业用户"]
                    popoverPresentationControllerBlock:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                        NSInteger index = buttonIndex - firstOtherIndex;
                        IBLCreateAccountUserType createAccountType = index == 0 ? IBLCreateAccountUserTypeDetault : IBCreateAccountLUserTypeEnterprise;
                        NSInteger cerType = index == 0 ? 0 : 6;
                        self.createAccountInfo.userType = createAccountType;
                        self.createAccountInfo.certType = cerType;
                        self.userTypeTextField.text = [self userTypeNames][@(self.createAccountInfo.userType)];
                        self.identifierTypeTextField.text = [self certTypeNames][@(cerType)];
                        [self cleanUserInfo];
                        [self.tableView reloadData];
                    }];
}

- (void)cleanUserInfo{
    self.usernameTextField.text = nil;
    self.phoneTextField.text = nil;
    self.addressTextField.text = nil;
    self.enterpriseTextField.text = nil;
    self.enterprisesPhoneTextField.text = nil;
    self.enterprisesAddressTextField.text = nil;
    self.enterprisesContactTextField.text = nil;
    self.enterprisesSampleNameTextField.text = nil;
    
    self.createAccountInfo.username = nil;
    self.createAccountInfo.phone = nil;
    self.createAccountInfo.address = nil;
    self.createAccountInfo.companyName = nil;
    self.createAccountInfo.companyPhone = nil;
    self.createAccountInfo.companyAddress = nil;
    self.createAccountInfo.companyContact = nil;
    self.createAccountInfo.simpleComName = nil;
}

- (IBAction)effectTypeTapped:(UITapGestureRecognizer *)sender {
    //!!!: 优化将title 和 effect 提取到appConfig中
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择生效方式"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"指定日期", @"首次上线"]
                    popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
                        
                    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                        NSInteger index = buttonIndex - firstOtherIndex;
                        IBLOrderEffectType effType = index == 0 ? IBLOrderEffectTypeBeforeTheDate : IBLOrderEffectTypeFirst;
                        self.createAccountInfo.effectType = effType;
                        self.methodOfValidTextField.text = [self effectNames][@(self.createAccountInfo.effectType)];
                        [self.tableView reloadData];
                    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"IBLSectionHeaderView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"IBLSectionHeaderView"];
    
    IBLCreateAccountType createAccountType = [self.tableViewDataSource createAccountTypeOfTableViewController:self];
    
    self.commentTextView.textContainerInset = UIEdgeInsetsZero;
    self.createAccountInfo = [self.tableViewDataSource createAccountInfoOfTableViewController:self];
    self.countTextField.text = @"1";
    switch (createAccountType) {
        case IBLCreateAccountTypeFromOrder: {
            self.regionTextField.text = self.createAccountInfo.regionName;
            self.productTextField.text = self.createAccountInfo.productName;
            self.methodOfValidTextField.text = [self effectNames][@(self.createAccountInfo.effectType)];
            self.dateOfValidTextField.text = self.createAccountInfo.effectDate;
            self.usernameTextField.text = self.createAccountInfo.username;
            self.phoneTextField.text = self.createAccountInfo.phone;
            self.addressTextField.text = self.createAccountInfo.address;
            self.identifierTextField.text = self.createAccountInfo.identifierNumber;
            self.commentTextView.text = self.createAccountInfo.remark;
            self.enterprisesPhoneTextField.text = self.createAccountInfo.companyPhone;
            self.enterpriseTextField.text = self.createAccountInfo.companyName;
            self.enterprisesAddressTextField.text = self.createAccountInfo.companyAddress;
            self.enterprisesContactTextField.text = self.createAccountInfo.companyContact;
            self.userTypeTextField.text = [self userTypeNames][@(self.createAccountInfo.userType)];
            self.enterprisesSampleNameTextField.text = self.createAccountInfo.simpleComName;
            @weakify(self)
            [self.tableViewDataSource productPriceOfTableViewController:self
                                                        completeHandler:^(IBLProductPrice *productPrice) {
                                                            @strongify(self)
                                                            self.productPrice = productPrice;
                                                            [self setupPriceWithProductPrice];
                                                        }];
            break;
        }
        case IBLCreateAccountTypeFromLeftMenu: {
            self.createAccountInfo.effectType = [self.tableViewDataSource defaultEffectTypeOfTableViewController:self];
            self.createAccountInfo.effectDate = [self.tableViewDataSource defaultEffectDateOfTableViewController:self];
            self.methodOfValidTextField.text = [self effectNames][@(self.createAccountInfo.effectType)];
            self.dateOfValidTextField.text = [[NSDate date] stringFromFormatter:@"yyyy-MM-dd"];
            self.createAccountInfo.userType = [IBLAppRepository appConfiguration].custType;
            if (self.createAccountInfo.userType == 1) {
                self.createAccountInfo.certType = 6;
            }

            break;
        }
    }
    
    [self setPriceTextFieldsEnable:NO];
    
    for (UITextField *textField in [self priceTextFields]){
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    self.countTextField.delegate = self;
    
    self.phoneTextField.delegate = self;
    
    self.identifierTextField.delegate = self;
    
    self.giveTextField.text = @"";
    
    self.giveTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.countTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.identifierTextField.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.enterprisesPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.userTypeTextField.text = [self userTypeNames][@( self.createAccountInfo.userType)];
    
    if (self.createAccountInfo.userType == IBCreateAccountLUserTypeEnterprise) self.createAccountInfo.certType = 6;
    self.identifierTypeTextField.text = [self certTypeNames][@(self.createAccountInfo.certType)];
    
}

- (void)setPriceTextFieldsEnable:(BOOL)enable{
    NSString *placeholder = enable ? @"请输入" : @"请选择销售品";
    
    for (UITextField *textField in [self priceTextFields]) {
        textField.placeholder = placeholder;
        textField.enabled = enable;
    }
    self.countTextField.enabled = enable;
    self.countTextField.placeholder = placeholder;
}

- (NSArray<UITextField *> *)priceTextFields{
    return @[self.payTextField,
             self.discountTextField,
             self.giveTextField];
}

- (BOOL)validatePriceWithTextField:(UITextField *)textField{
    
    BOOL isNumber = [self validateNumberWithText:textField.text];
    
    if (!isNumber) return NO;

    return ![self validateTextFields:textField] ? NO : YES;

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;{
    
    if (textField == self.countTextField) {
        if ( [self.countTextField.text integerValue] <= 0) {
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
    
    if (textField == self.phoneTextField && ![NSString isNull:self.phoneTextField.text]) {
        if ([IBLUtilities validateMobile:textField.text]) return YES;
        NSError *error = [NSError errorWithDomain:@""
                                             code:0
                                         userInfo:@{kExceptionCode : @(-1),
                                                    kExceptionMessage: @"您输入的手机格式不正确！"}];
        [self showAlertWithError:error];
        return NO;
    }
    
    if ((textField == self.enterprisesPhoneTextField && ![NSString isNull:self.enterprisesPhoneTextField.text])) {
        if ([IBLUtilities validateMobile:textField.text]) return YES;
        NSError *error = [NSError errorWithDomain:@""
                                             code:0
                                         userInfo:@{kExceptionCode : @(-1),
                                                    kExceptionMessage: @"您输入的手机格式不正确！"}];
        [self showAlertWithError:error];
        return NO;

        
    }
    
    if (textField == self.identifierTextField && ![NSString isNull:self.identifierTextField.text]
         && self.createAccountInfo.certType == 0) {
        if ([IBLUtilities validateIdentityCard:self.identifierTextField.text]) return YES;
        
        NSError *error = [NSError errorWithDomain:@""
                                             code:0
                                         userInfo:@{kExceptionCode : @(-1),
                                                    kExceptionMessage: @"您输入的身份证号码格式不正确！"}];
        [self showAlertWithError:error];
        return NO;
    }
    
    
    return YES;
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.countTextField){
        [self setupRenewCount];
    }else if (textField == self.discountTextField) {
        [self setupPay];
    }else if (textField == self.payTextField){
        [self setupDiscount];
    }else if (textField == self.giveTextField){
        [self setupSalesCount];
    }
}

- (void)setupRenewCount{
    self.discountTextField.text = @"";
    self.giveTextField.text = @"";
    [self setupSales];
    [self setupPay];
    [self setupSalesCount];
}

- (void)setupPriceWithProductPrice{
    self.discountTextField.text = @"";
    self.giveTextField.text = @"";
    self.countTextField.text = @"1";
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
    NSInteger count = [self.countTextField.text integerValue];
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
    NSInteger count = [self.countTextField.text integerValue];
    
    return (unitPrice * count) / 100.0;
}

- (void)setupSales{
    self.salesTextField.text = [@([self sales]) stringValue];
}

- (CGFloat)salesCount{
    // 销售品总量 =  单个销售品总周期数(totalLength) * 订购数量 + 临时赠送
    NSInteger totalLength = self.productPrice.totalLength;
    
    // 订购数量
    NSInteger count = [self.countTextField.text integerValue];
    
    // 临时赠送
    NSInteger given = [self.giveTextField.text integerValue];
    
    return totalLength * count + given;
}

- (void)setupSalesCount{
    self.salesCountLabel.text = [NSString stringWithFormat:@"销售品总量%@",[self unit]];
    self.salesCountTextField.text = [@([self salesCount]) stringValue];
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
    NSInteger count = [self.countTextField.text integerValue];
    
    // 支付金额
    NSInteger pay = aPay * 100;
    
    return (unitPrice * count - pay) / 100.0;
}

- (void)setupDiscount{
    if ([self discountWithPay:[self.payTextField.text doubleValue]] <= 0)
        self.discountTextField.text = @"";
    else
        self.discountTextField.text = [@([self discountWithPay:[self.payTextField.text doubleValue]]) stringValue];
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

//!!!: 优化将title 和 effect 提取到appConfig中
- (NSDictionary<NSNumber *,NSString *> *)effectNames{
    return @{@(1) : @"指定日期",
             @(2) : @"首次上线"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary<NSNumber *,NSString *> *)sectionTitles{
    return @{@(0) : @"基本选项",
             @(1) : @"开户资料",
             @(2) : @"结算"};
}

- (NSDictionary <NSIndexPath *, UITextField *> *)test{
    NSIndexPath *account = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *password = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *custIdCard = [NSIndexPath indexPathForRow:1 inSection:1];

    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:3 inSection:1];
    NSIndexPath *custAddress = [NSIndexPath indexPathForRow:4 inSection:1];

    NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:5 inSection:1];
    NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:6 inSection:1];
    NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:7 inSection:1];
    NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:8 inSection:1];
    NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:9 inSection:1];
    
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:10 inSection:1];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:3 inSection:2];

    NSMutableDictionary *notNullDictionary = [NSMutableDictionary dictionary];
    if (self.createAccountInfo.userType == IBCreateAccountLUserTypeEnterprise) {
        notNullDictionary[enterpriseNameIndexPath] = self.enterpriseTextField;
        notNullDictionary[enterpriseContactIndexPath] = self.enterprisesContactTextField;
        notNullDictionary[enterprisePhoneIndexPath] = self.enterprisesPhoneTextField;
        notNullDictionary[enterpriseAddressIndexPath] = self.enterprisesAddressTextField;
        notNullDictionary[enterpriseSampleNameIndexPath] = self.enterprisesSampleNameTextField;
    }else {
        notNullDictionary[custNameIndexPath] = self.usernameTextField;
        notNullDictionary[custPhone] = self.phoneTextField;
        notNullDictionary[custAddress] = self.addressTextField;

    }
    notNullDictionary[custIdCard] = self.identifierTextField;
    notNullDictionary[custReserve] = self.commentTextView;
    notNullDictionary[contractCode] = self.contractNumberTextField;
    notNullDictionary[voiceCode] = self.ticketNumberTextField;
    notNullDictionary[account] = self.accountTextField;
    notNullDictionary[password] = self.passwordTextField;


    
    return notNullDictionary;
}

- (NSDictionary <NSIndexPath *, NSString *> *)notNullTitleDictionary{
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:3 inSection:1];
    NSIndexPath *custIdCard = [NSIndexPath indexPathForRow:4 inSection:1];
    NSIndexPath *custAddress = [NSIndexPath indexPathForRow:6 inSection:1];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:3 inSection:2];
    NSIndexPath *account = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *password = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:10 inSection:1];
    

    
    NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:5 inSection:1];
    NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:6 inSection:1];
    NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:7 inSection:1];
    NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:8 inSection:1];
    NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:9 inSection:1];
    
    
    NSMutableDictionary *notNullDictionary = [NSMutableDictionary dictionary];
    if (self.createAccountInfo.userType == IBLCreateAccountUserTypeDetault) {
        notNullDictionary[custNameIndexPath] = @"用户名不能为空！";
        notNullDictionary[custPhone] = @"联系电话不能为空！";
        notNullDictionary[custAddress] = @"联系地址不能为空！";
    }else {
        notNullDictionary[enterpriseNameIndexPath] = @"企业名称不能为空！";
        notNullDictionary[enterpriseContactIndexPath] = @"企业联系人不能为空！";
        notNullDictionary[enterprisePhoneIndexPath] = @"企业联系电话不能为空！";
        notNullDictionary[enterpriseAddressIndexPath] = @"企业联系地址不能为空！";
        notNullDictionary[enterpriseSampleNameIndexPath] = @"企业简称不能为空！";
    }

    notNullDictionary[custIdCard] = @"证件号不能为空！";
    notNullDictionary[custReserve] = @"备注不能为空！";
    notNullDictionary[contractCode] = @"合同号不能为空！";
    notNullDictionary[voiceCode] = @"票据号不能为空！";
    notNullDictionary[account] = @"账户不能为空！";
    notNullDictionary[password] = @"密码不能为空！";


    return notNullDictionary;
}

- (BOOL)validateNotNullFields{
    NSDictionary <NSIndexPath *, NSString *> *notNullFields = [self.tableViewDataSource notNullFieldsDictionary];
    
    NSArray *indexPaths = [notNullFields.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSString *notNullText = nil;
    
    for (NSIndexPath *indexPath in indexPaths) {
        UITextField *textField = [self test][indexPath];
        if([NSString isNull:textField.text] && textField != nil) {
            notNullText = [self notNullTitleDictionary][indexPath];
            break;
        }
    }
    
    BOOL isHiddenAccount = [self.tableViewDataSource isHiddenAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    BOOL isHiddenPassword = [self.tableViewDataSource isHiddenAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (!isHiddenAccount && [NSString isNull:self.accountTextField.text]) {
        notNullText = @"用户账户不能为空！";
    }
    
    if (!isHiddenPassword && [NSString isNull:self.passwordTextField.text]) {
        notNullText = @"用户密码不能为空！";
        
    }
    
    if ([NSString isNull:self.productTextField.text]) {
        notNullText = @"请选择销售品！";
        
    }
    
    if ([NSString isNull:self.methodOfValidTextField.text]) {
        notNullText = @"请选择生效方式！";
    }else{
        if (self.createAccountInfo.effectType == IBLOrderEffectTypeBeforeTheDate) {
            if ([NSString isNull:self.dateOfValidTextField.text]) {
                notNullText = @"请选择上线日期！";
            }
        }
    }
    
    if ([NSString isNull:self.regionTextField.text]) {
        notNullText = @"请选择区域！";
    }
    
    if (notNullText) {
        [self showAlertWithError:errorWithCode(0, notNullText)];
        return NO;
    }
    
    return YES;
    
}

- (void)saveCreateAccountInfo{
    self.createAccountInfo.account = self.accountTextField.text;
    self.createAccountInfo.password = self.passwordTextField.text;
    self.createAccountInfo.identifierNumber = self.identifierTextField.text;
    self.createAccountInfo.remark = self.commentTextView.text;
    self.createAccountInfo.phone = self.phoneTextField.text;
    self.createAccountInfo.address = self.addressTextField.text;
    self.createAccountInfo.count = [self.countTextField.text integerValue];
    self.createAccountInfo.sales = [self sales];
    self.createAccountInfo.salesCount = [self.salesCountTextField.text integerValue];
    self.createAccountInfo.contractNumebr = self.contractNumberTextField.text;
    self.createAccountInfo.ticketNumber = self.ticketNumberTextField.text;
    self.createAccountInfo.give = [self.giveTextField.text integerValue];
    self.createAccountInfo.discount = [self.discountTextField.text doubleValue];
    self.createAccountInfo.pay = [self.payTextField.text doubleValue];
    self.createAccountInfo.username = self.usernameTextField.text;
    self.createAccountInfo.companyName = self.enterpriseTextField.text;
    self.createAccountInfo.companyPhone = self.enterprisesPhoneTextField.text;
    self.createAccountInfo.companyContact = self.enterprisesContactTextField.text;
    self.createAccountInfo.companyAddress = self.enterprisesAddressTextField.text;
    self.createAccountInfo.simpleComName = self.enterprisesSampleNameTextField.text;
}

- (IBAction)commitButtonPressed:(UIButton *)sender {
    if (![self validateNotNullFields]) return;
    
    [self saveCreateAccountInfo];
    
    [self.tableViewDataSource tableViewController:self commit:self.createAccountInfo];
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IBLSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"IBLSectionHeaderView"];
    header.nameLabel.text = [self sectionTitles][@(section)];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isHidden = [self.tableViewDataSource isHiddenAtIndexPath:indexPath];
    
    if (isHidden) return 0;
    
    if([indexPath isEqual:[NSIndexPath indexPathForRow:10 inSection:1]]) return 87;
    
    if ([self isHiddenEffectDate] && [indexPath isEqual:[NSIndexPath indexPathForRow:6 inSection:0]]) return 0;
    
    if ([self isHiddenAtIndexPath:indexPath]) return 0;
    
    return 30;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *hiddenIndexPaths = nil;
    
    if (self.createAccountInfo.userType == IBLCreateAccountUserTypeDetault) {
        NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:5 inSection:1];
        NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:6 inSection:1];
        NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:7 inSection:1];
        NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:8 inSection:1];
        NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:9 inSection:1];

        hiddenIndexPaths = [@[enterpriseNameIndexPath,
                  enterpriseContactIndexPath,
                  enterprisePhoneIndexPath,
                  enterpriseAddressIndexPath,
                  enterpriseSampleNameIndexPath] mutableCopy];
    }else{
        NSIndexPath *userNameIndexPath = [NSIndexPath indexPathForRow:2 inSection:1];
        NSIndexPath *phoneIndexPath = [NSIndexPath indexPathForRow:3 inSection:1];
        NSIndexPath *addressIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];

        hiddenIndexPaths = [@[userNameIndexPath,
                  phoneIndexPath,
                  addressIndexPath] mutableCopy];

    }
    
    NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
    
    if ([IBLAppRepository appConfiguration].showCustType == 0) {
        [hiddenIndexPaths addObject:userTypeIndexPath];
    }

    
    
    return [hiddenIndexPaths containsObject:indexPath];
}

- (BOOL)isHiddenEffectDate{
    return self.createAccountInfo.effectType == IBLOrderEffectTypeFirst;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"CreateAccountRegionForSearch"]){
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        searchViewController.viewModel = [IBLRegionSearchViewModel regionSearchModelWithSearchType:IBLSearchTypeCreateAccountArea];
        searchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:@"CreateAccountProductForSearch"]){
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        searchViewController.viewModel = [IBLProductSearchViewModel productSearchModelWithSearchType:IBLSearchTypeCreateAccountProduct
                                                                                           productId:0
                                                                                            regionId:self.createAccountInfo.residentialIdentifier];
        searchViewController.searchDelegate = self;
    }
}


- (void)searchViewController:(IBLSearchViewController *)searchViewController
           didSelectedResult:(id)searchResult {
    switch (searchViewController.viewModel.searchType) {
            
        case IBLSearchTypeCreateAccountArea: {
            IBLRegion *region = searchResult;
            self.createAccountInfo.regionName = region.name;
            self.createAccountInfo.residentialIdentifier = region.identifier;
            self.regionTextField.text = region.name;
            
            break;
        }
        case IBLSearchTypeCreateAccountProduct: {
            IBLProduct *product = searchResult;
            self.createAccountInfo.productName = product.name;
            self.createAccountInfo.productIdentifier = product.identifier;
            self.productTextField.text = product.name;
            [self.tableViewDataSource productPriceOfTableViewController:self
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
