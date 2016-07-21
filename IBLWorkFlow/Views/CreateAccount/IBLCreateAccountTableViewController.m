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


@implementation IBLCreateAccountInfo

- (instancetype)initWithResidentialIdentifier:(NSInteger)residentialIdentifier
                            productIdentifier:(NSInteger)productIdentifier
                                     username:(NSString *)username
                                   regionName:(NSString *)regionName
                                  productName:(NSString *)productName
                             identifierNumber:(NSString *)identifierNumber
                                       remark:(NSString *)remark
                                   effectType:(NSString *)effectType
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
                                   effectType:(NSString *)effectType
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

@interface IBLCreateAccountTableViewController ()<IBLSearchViewControllerDelegate>

@property (nonatomic, strong) IBLCreateAccountInfo *createAccountInfo;

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
/// 优惠金额
@property (weak, nonatomic) IBOutlet UITextField *giveTextField;
/// 临时赠送
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
/// 支付金额
@property (weak, nonatomic) IBOutlet UITextField *payTextField;

@end

@implementation IBLCreateAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"IBLSectionHeaderView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"IBLSectionHeaderView"];
    self.createAccountInfo = [self.tableViewDataSource createAccountInfoOfTableViewController:self];
    self.regionTextField.text = self.createAccountInfo.regionName;
    self.productTextField.text = self.createAccountInfo.productName;
    self.methodOfValidTextField.text = self.createAccountInfo.effectType;
    self.dateOfValidTextField.text = self.createAccountInfo.effectDate;
    self.usernameTextField.text = self.createAccountInfo.username;
    self.phoneTextField.text = self.createAccountInfo.phone;
    self.addressTextField.text = self.createAccountInfo.address;
    self.identifierTextField.text = self.createAccountInfo.identifierNumber;
    self.commentTextView.text = self.createAccountInfo.remark;
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

- (IBAction)commitButtonPressed:(UIButton *)sender {
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
    return isHidden ? 0 : 30;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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
        searchViewController.viewModel = [IBLProductSearchViewModel productSearchModelWithSearchType:IBLSearchTypeProduct
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
        case IBLSearchTypeProduct: {
            IBLProduct *region = searchResult;
            self.createAccountInfo.regionName = region.name;
            self.createAccountInfo.residentialIdentifier = region.identifier;
            self.regionTextField.text = region.name;

            break;
        }
        default: break;
    }
}


@end
