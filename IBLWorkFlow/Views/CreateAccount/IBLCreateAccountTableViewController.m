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
#import "IBLAlertController.h"
#import "RMDateSelectionViewController.h"

@implementation IBLCreateAccountInfo

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

@property (nonatomic, strong, readwrite) IBLCreateAccountInfo *createAccountInfo;

/// 用户账号
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
/// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
/// 所属小区
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
/// 支付金额
@property (weak, nonatomic) IBOutlet UITextField *payTextField;

@property (nonatomic, strong) IBLProductPrice *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *giveLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesCountLabel;

@end

@implementation IBLCreateAccountTableViewController
- (IBAction)effectDateTapped:(UITapGestureRecognizer *)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.disableBouncingWhenShowing = YES;
    dateSelectionVC.datePicker.minuteInterval = 1;
    
    dateSelectionVC.disableBlurEffects = YES;
    
    dateSelectionVC.hideNowButton = YES;
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        self.createAccountInfo.effectDate = [aDate stringFromFormatter:@"yyyy/MM/dd HH:mm:ss"];
        self.dateOfValidTextField.text = self.createAccountInfo.effectDate;
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
    }];

}

- (IBAction)effectTypeTapped:(UITapGestureRecognizer *)sender {
    //!!!: 优化将title 和 effect 提取到appConfig中
    IBLButtonItem *beforeTheDate = [IBLButtonItem itemWithLabel:@"指定日期"
                                                         action:^(IBLButtonItem *item) {
                                                             self.createAccountInfo.effectType = IBLOrderEffectTypeBeforeTheDate;
                                                             self.methodOfValidTextField.text = [self effectNames][@(self.createAccountInfo.effectType)];
                                                             [self.tableView reloadData];
                                                         }];
    
    IBLButtonItem *first = [IBLButtonItem itemWithLabel:@"首次上线"
                                                 action:^(IBLButtonItem *item) {
                                                     self.createAccountInfo.effectType = IBLOrderEffectTypeFirst;
                                                     self.methodOfValidTextField.text = [self effectNames][@(self.createAccountInfo.effectType)];
                                                     [self.tableView reloadData];
                                                 }];
    
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];

    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                    title:@"请选择生效方式"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                         otherButtonItems:beforeTheDate,first,nil];
    [alert showInController:self];
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
            break;
        }
    }
    
    self.payTextField.delegate = self;
    self.salesCountTextField.delegate = self;
    self.salesTextField.delegate = self;
    self.discountTextField.delegate = self;
    self.giveTextField.delegate = self;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;{
    BOOL isNumber = [self validateNumberWithText:textField.text];
    
    if (!isNumber) return NO;
    
    if (![self validateTextFields]) return NO;
    
    return YES;
}

- (BOOL)validateTextFields{
    
    BOOL isValidate = YES;
    
    NSString *title = @"";
    
    // 支付金额
    CGFloat pay = [self pay];
    // 销售品总金额
    CGFloat sales = [self sales];
    // 优惠金额
    CGFloat discount = [self discount];
    
    if (pay < 0) {
        title = @"支付金额必须大于0";
        isValidate = NO;
    }
    
    if (pay > sales) {
        title = @"销售品总额必须大于支付金额";
        isValidate = NO;
    }
    
    if (discount < 0) {
        title = @"优惠金额必须大于0";
        isValidate = NO;
    }
    
    if (sales < discount) {
        title = @"优惠金额必须小于总金额";
        isValidate = NO;
    }
    
    if (!isValidate) {
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:title
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
    }
    
    return  isValidate;
}

- (BOOL)validateNumberWithText:(NSString *)text{
    if ([NSString isNull:text]) return YES;
    
    NSString *regex = @"^(([1-9]\\d{0,12})|0)(\\.\\d{0,2})?$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isNumber = [predicate evaluateWithObject:text];
    
    if (!isNumber) {
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:@"请输入大于0的数字！"
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
    }
    
    return isNumber;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.discountTextField) {
        [self setupPay];
    }else if (textField == self.payTextField){
        [self setupDiscount];
    }else if (textField == self.giveTextField){
        [self setupSalesCount];
    }
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
    NSInteger unitPrice = self.productPrice.unitPrice;
    // 订购数量
    NSInteger count = [self.countTextField.text integerValue];
    // 优惠金额
    NSInteger discount = [self.discountTextField.text doubleValue] * 100;
    
    return (unitPrice * count - discount) / 100.0f;
}

- (void)setupPay{
    self.payTextField.text = [@([self pay]) stringValue];
}

- (CGFloat)sales{
    // 销售品总金额 = 单个销售品金额（totalFee） ＊ 订购数量
    
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.unitPrice;
    
    // 订购数量
    NSInteger count = [self.countTextField.text integerValue];
    
    return (unitPrice * count) / 100.0f;
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

- (CGFloat)discount{
    // 优惠金额 = 单个销售品金额（totalFee） ＊ 订购数量 - 支付金额
    // 单个销售品总额
    NSInteger unitPrice = self.productPrice.unitPrice;
    
    // 订购数量
    NSInteger count = [self.countTextField.text integerValue];
    
    // 支付金额
    NSInteger pay = [self.payTextField.text doubleValue] * 100;
    
    return (unitPrice * count - pay) / 100.0f;
}

- (void)setupDiscount{
    self.discountTextField.text = [@([self discount]) stringValue];
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
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *custIdCard = [NSIndexPath indexPathForRow:3 inSection:1];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:4 inSection:1];
    NSIndexPath *custAddress = [NSIndexPath indexPathForRow:2 inSection:1];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:3 inSection:2];

    return @{custNameIndexPath : self.accountTextField,
             custPhone : self.phoneTextField,
             custIdCard : self.identifierTextField,
             custReserve : self.commentTextView,
             custAddress : self.addressTextField,
             contractCode : self.contractNumberTextField,
             voiceCode : self.ticketNumberTextField,
             };
}

- (NSDictionary <NSIndexPath *, NSString *> *)notNullTitleDictionary{
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *custIdCard = [NSIndexPath indexPathForRow:3 inSection:1];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:4 inSection:1];
    NSIndexPath *custAddress = [NSIndexPath indexPathForRow:2 inSection:1];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:3 inSection:2];

    return @{ custNameIndexPath : @"用户名不能为空！",
             custPhone : @"联系电话不能为空！",
             custIdCard : @"身份证号不能为空！",
             custReserve : @"备注不能为空！",
             custAddress : @"联系地址不能为空！",
             contractCode : @"合同号不能为空！",
             voiceCode : @"票据号不能为空！",
             };
}

- (IBAction)commitButtonPressed:(UIButton *)sender {
    NSDictionary <NSIndexPath *, NSString *> *notNullFields = [self.tableViewDataSource notNullFieldsDictionary];
    
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
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:notNullText
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
    }else{
        [self.tableViewDataSource tableViewController:self commit:self.createAccountInfo];
    }
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

    if([indexPath isEqual:[NSIndexPath indexPathForRow:4 inSection:1]]) return 87;
    
    if ([self isHiddenEffectDate] && [indexPath isEqual:[NSIndexPath indexPathForRow:6 inSection:0]]) return 0;
    
    return 30;
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
                                                                                           productId:self.createAccountInfo.productIdentifier
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
