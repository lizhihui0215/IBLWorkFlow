//
//  IBLAddWorkOrderTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAddWorkOrderTableViewController.h"
#import "IBLPickerView.h"
#import "HcdDateTimePickerView.h"
#import "IBLSearchViewController.h"
#import "IBLUserSearchViewController.h"

static NSString *const IBLSearchForHandleUserIdentifier = @"SearchForHandleUser";

static NSString *const IBLSearchForProductIdentifier = @"SearchForProduct";

static NSString *const IBLSearchForRegionIdentifier = @"SearchForRegion";

static NSString *const IBLSearchForRelateUserIdentifier = @"SearchForRelateUser";

@interface IBLAddWorkOrderTableViewController () <IBLSearchViewControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *workOrderTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *workOrderBizTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UITextField *finishedDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *productCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIdentifierTextField;
//@property (weak, nonatomic) IBOutlet UITextField *workOrderContentTextField;
@property (weak, nonatomic) IBOutlet UITextView *workOrderContentTextView;


@property (weak, nonatomic) IBOutlet UITextField *relateUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *handleUserTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end

@implementation IBLAddWorkOrderTableViewController

- (IBAction)priorityTapped:(UITapGestureRecognizer *)sender {
    
    IBLButtonItem *emergency = [IBLButtonItem itemWithLabel:@"紧急"
                                                     action:^(IBLButtonItem *item) {
                                                         self.priorityTextField.text = item.label;
                                                         [self.tableViewDelegate addWorkOrderTableView:self
                                                                                             fieldType:IBLAddWorkOrderFieldTypePriority
                                                                                            didEndEdit:@(IBLPriorityStatusEmergency)];
                                                         
                                                     }];
    
    IBLButtonItem *general = [IBLButtonItem itemWithLabel:@"一般"
                                                   action:^(IBLButtonItem *item) {
                                                       self.priorityTextField.text = item.label;
                                                       [self.tableViewDelegate addWorkOrderTableView:self
                                                                                           fieldType:IBLAddWorkOrderFieldTypePriority
                                                                                          didEndEdit:@(IBLPriorityStatusGeneral)];
                                                       
                                                   }];
    
    IBLButtonItem *noEmergency = [IBLButtonItem itemWithLabel:@"不紧急"
                                                       action:^(IBLButtonItem *item) {
                                                           self.priorityTextField.text = item.label;
                                                           [self.tableViewDelegate addWorkOrderTableView:self
                                                                                               fieldType:IBLAddWorkOrderFieldTypePriority
                                                                                              didEndEdit:@(IBLPriorityStatusNoEmergency)];
                                                           
                                                       }];
    
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
    
    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                    title:@"请选择生效方式"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                         otherButtonItems:emergency,general,noEmergency,nil];
    [alert showInController:self];
}
- (IBAction)handleUserTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:IBLSearchForHandleUserIdentifier sender:self];
}
- (IBAction)relateUserTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:IBLSearchForRelateUserIdentifier sender:self];
}
- (IBAction)finishedDateTapped:(UITapGestureRecognizer *)sender {
    
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateTimeMode
                                                                              defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    datePicker.formatter = formatter;
    [datePicker showHcdDateTimePicker];
    datePicker.clickedOkBtn = ^(NSString *time){
        //        [aDate stringFromFormatter:@"yyyy-MM-dd HH:mm:ss"]
        self.finishedDateTextField.text = time;
        [self.tableViewDelegate addWorkOrderTableView:self
                                            fieldType:IBLAddWorkOrderFieldTypeFinishedDate
                                           didEndEdit:self.finishedDateTextField.text];
    };
}
- (IBAction)productTapped:(UITapGestureRecognizer *)sender {
    IBLRegion *region = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeRegion];
    
    IBLWorkOrderBussinessType *biz = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeBizType];
    if (!region && biz.status == IBLWorkOrderBizStatusInstall) {
        NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{kExceptionCode : @(0),
                                                                        kExceptionMessage : @"请选择小区!"}];
        
        [self showAlertWithError:error];
        return;
    }
    
    [self performSegueWithIdentifier:IBLSearchForProductIdentifier sender:self];
    
}
- (IBAction)regionTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:IBLSearchForRegionIdentifier sender:self];
}

- (IBAction)workOrderBizTypeTapped:(UITapGestureRecognizer *)sender {
    
    IBLWorkOrderType *workOrderType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeWorkOrderType];
    
    if (!workOrderType) {
        NSError *error = [NSError errorWithDomain:@""
                                             code:0
                                         userInfo:@{kExceptionCode : @"-1",
                                                    kExceptionMessage: @"请选择工单类型！"}];
        [self showAlertWithError:error];
        return;
    }
    
    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.tableViewDelegate workOrderBizTypesOfTableView:self ];
    
    [IBLPickerView showPickerViewInView:self.view.superview
                            withObjects:businessTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderBussinessType *workOrderBizType) {
                    return workOrderBizType.name;
                } completion:^(IBLWorkOrderBussinessType *workOrderBizType) {
                    [self.tableViewDelegate addWorkOrderTableView:self
                                                        fieldType:IBLAddWorkOrderFieldTypeBizType
                                                       didEndEdit:workOrderBizType];
                    self.workOrderBizTypeTextField.text = workOrderBizType.name;
                    [self.tableView reloadData];
                }];
}
- (IBAction)workOrderTypeTapped:(UITapGestureRecognizer *)sender {
    
    NSArray<IBLWorkOrderType *> *workOrderTypes = [self.tableViewDelegate workOrderTypesOfTableView:self];
    
    [IBLPickerView showPickerViewInView:self.view.superview
                            withObjects:workOrderTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderType *workOrderType) {
                    return workOrderType.name;
                } completion:^(IBLWorkOrderType *workOrderType) {
                    [self.tableViewDelegate addWorkOrderTableView:self
                                                        fieldType:IBLAddWorkOrderFieldTypeWorkOrderType
                                                       didEndEdit:workOrderType];
                    self.workOrderTypeTextField.text = workOrderType.name;
                    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.tableViewDelegate workOrderBizTypesOfTableView:self];
                    IBLWorkOrderBussinessType *first = businessTypes.firstObject;
                    [self.tableViewDelegate addWorkOrderTableView:self
                                                        fieldType:IBLAddWorkOrderFieldTypeBizType
                                                       didEndEdit:first];
                    self.workOrderBizTypeTextField.text = first.name;
                    [self.tableView reloadData];
                }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    IBLWorkOrderBussinessType *bizType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeBizType];
    
    if ([[self hiddenFieldsDictionaryWithWorkBizType:bizType.status][indexPath] boolValue]) return 0;
    
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:14 inSection:0]]) return 87;
    
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:11 inSection:0]]) return 98;
    
    return 40;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}



- (NSDictionary<NSIndexPath *, NSNumber* > *)hiddenFieldsDictionaryWithWorkBizType:(IBLWorkOrderBizStatus)bizType{
    NSDictionary *dic;
    self.productTextField.hidden = NO;
    self.productCountTextField.hidden = NO;
    self.usernameTextField.hidden = NO;
    self.phoneTextField.hidden = NO;
    self.addressTextField.hidden = NO;
    self.userIdentifierTextField.hidden = NO;
    self.relateUserTextField.hidden = NO;
    self.remarkTextView.hidden = NO;
    self.workOrderContentTextView.hidden = NO;
    self.regionTextField.hidden = NO;

    switch (bizType) {
        case IBLWorkOrderBizStatusUnknow: {
            break;
        }
            
        case IBLWorkOrderBizStatusInstall: {
            self.workOrderContentTextView.hidden = YES;
            self.relateUserTextField.hidden = YES;
            NSIndexPath *indexPathWorkOrderContent = [NSIndexPath indexPathForRow:11 inSection:0];
            NSIndexPath *indexPathRelateUser = [NSIndexPath indexPathForRow:12 inSection:0];
            dic = @{indexPathWorkOrderContent : @(YES),
                    indexPathRelateUser : @(YES)};
            break;
        }
            
        case IBLWorkOrderBizStatusElectrical:
        case IBLWorkOrderBizStatusAddBox:
        case IBLWorkOrderBizStatusChangeBox:
        case IBLWorkOrderBizStatusAddLock:
        case IBLWorkOrderBizStatusFlyLine:
        case IBLWorkOrderBizStatusSplice:
        case IBLWorkOrderBizStatusThroughCable:
        case IBLWorkOrderBizStatusLightBarrier:
        case IBLWorkOrderBizStatusLineBarrier:
        case IBLWorkOrderBizStatusCableBreak:
        case IBLWorkOrderBizStatusOther: {
            NSIndexPath *productIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            NSIndexPath *countIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            NSIndexPath *phoneIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
            NSIndexPath *addressIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
            NSIndexPath *userIdentifierIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
            NSIndexPath *relateUserIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
            NSIndexPath *remarkIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
            self.productTextField.hidden = YES;
            self.productCountTextField.hidden = YES;
            self.usernameTextField.hidden = YES;
            self.phoneTextField.hidden = YES;
            self.addressTextField.hidden = YES;
            self.userIdentifierTextField.hidden = YES;
            self.relateUserTextField.hidden = YES;
            self.remarkTextView.hidden = YES;
            dic = @{productIndexPath : @(YES),
                    countIndexPath : @(YES),
                    usernameIndexPath : @(YES),
                    phoneIndexPath : @(YES),
                    addressIndexPath : @(YES),
                    userIdentifierIndexPath : @(YES),
                    relateUserIndexPath : @(YES),
                    remarkIndexPath : @(YES)};
            break;
        }
        default:{
            self.regionTextField.hidden = YES;
            self.productTextField.hidden = YES;
            self.productCountTextField.hidden = YES;
            self.usernameTextField.hidden = YES;
            self.phoneTextField.hidden = YES;
            self.addressTextField.hidden = YES;
            self.userIdentifierTextField.hidden = YES;
            self.remarkTextView.hidden = YES;
            NSIndexPath *regionIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            NSIndexPath *productIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            NSIndexPath *countIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            NSIndexPath *phoneIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
            NSIndexPath *addressIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
            NSIndexPath *userIdentifierIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
            NSIndexPath *remarkIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
            
            dic = @{regionIndexPath : @(YES),
                    productIndexPath : @(YES),
                    countIndexPath : @(YES),
                    usernameIndexPath : @(YES),
                    phoneIndexPath : @(YES),
                    addressIndexPath : @(YES),
                    userIdentifierIndexPath : @(YES),
                    remarkIndexPath : @(YES)};
            break;
        }
    }
    
    
    return dic;
    
}



- (NSString *)validateContents{
    NSString *title = nil;
    IBLWorkOrderBussinessType *type = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeBizType];
    
    if([NSString isNull:self.workOrderTypeTextField.text]){
        title = @"请选择工单类型！";
    };
    
    if([NSString isNull:self.workOrderBizTypeTextField.text]){
        title = @"请选择业务类型！";
    };
    
    if (type.status == IBLWorkOrderBizStatusInstall) {
        if([NSString isNull:self.regionTextField.text]){
            title = @"请选择小区！";
        };
        
        if([NSString isNull:self.productTextField.text]){
            title = @"请选择销售品！";
        };
        
        if([NSString isNull:self.productCountTextField.text]){
            title = @"请选填写订购数量！";
        };
        
        if(![IBLUtilities validateMobile:self.phoneTextField.text]){
            title = @"您输入的手机格式不正确！";
        };
        
    }else{
        if([NSString isNull:self.relateUserTextField.text]){
            title = @"请选择关联用户！";
        };
    }
    
    if ([self.productCountTextField.text integerValue] <= 0) {
        title = @"订购数量必须大于0！";
    }
    
    return title;
}

- (IBAction)commitTapped:(UIButton *)sender {
    NSString *title = [self validateContents];
    if (![NSString isNull:title]) {
        
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
        
        
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:title
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
        
        return;
    }
    [self saveWorkOrder];
    [self.tableViewDelegate addWorkOrderTableDidCommit:self];
}

- (NSString *)validateContent:(NSString *)content{
    return [NSString isNull:content] ? nil : content;
}

- (void)saveWorkOrder {
    NSString *username = [self validateContent:self.usernameTextField.text];
    NSString *phone = [self validateContent:self.phoneTextField.text];
    NSString *address = [self validateContent:self.addressTextField.text];
    NSString *userIdentifier = [self validateContent:self.userIdentifierTextField.text];
    NSString *workOrderContent = [self validateContent:self.workOrderContentTextView.text];
    NSString *remark = [self validateContent:self.remarkTextView.text];
    
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeUsername
                                       didEndEdit:username];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypePhone
                                       didEndEdit:phone];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeAddress
                                       didEndEdit:address];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeUserIdentifier
                                       didEndEdit:userIdentifier];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeWorkOrderContent
                                       didEndEdit:workOrderContent];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeRemark
                                       didEndEdit:remark];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    NSArray<IBLWorkOrderType *> *workOrderTypes = [self.tableViewDelegate workOrderTypesOfTableView:self];
    //
    //    IBLWorkOrderType *workOrderType = [workOrderTypes firstObject];
    //
    //    [self.tableViewDelegate addWorkOrderTableView:self
    //                                        fieldType:IBLAddWorkOrderFieldTypeWorkOrderType
    //                                       didEndEdit:workOrderType];
    //    self.workOrderTypeTextField.text = workOrderType.name;
    //    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.tableViewDelegate workOrderBizTypesOfTableView:self];
    //    IBLWorkOrderBussinessType *first = businessTypes.firstObject;
    //    [self.tableViewDelegate addWorkOrderTableView:self
    //                                        fieldType:IBLAddWorkOrderFieldTypeBizType
    //                                       didEndEdit:first];
    //    self.workOrderBizTypeTextField.text = first.name;
    
    self.productCountTextField.text = @"1";
    
    self.priorityTextField.text = @"一般";
    
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypePriority
                                       didEndEdit:@(IBLPriorityStatusGeneral)];

    [self.tableView reloadData];
    self.productCountTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.userIdentifierTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.productCountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.phoneTextField setShouldEndEditingBlock:^BOOL(UITextField *textField) {
        BOOL isVaidate = [IBLUtilities validateMobile:textField.text];
        if (!isVaidate) {
            IBLButtonItem *item = [IBLButtonItem itemWithLabel:@"确定"];
            
            IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                            title:@"电话号码格式不正确！"
                                                                          message:nil
                                                                 cancleButtonItem:item
                                                                 otherButtonItems:nil];
            [alert showInController:self];
        }
        
        return isVaidate;
    }];
    
    [self.userIdentifierTextField setShouldEndEditingBlock:^BOOL(UITextField *textField) {
        BOOL isVaidate = [IBLUtilities validateIdentityCard:textField.text];
        if (!isVaidate) {
            IBLButtonItem *item = [IBLButtonItem itemWithLabel:@"确定"];
            
            IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                            title:@"身份证号码格式不正确！"
                                                                          message:nil
                                                                 cancleButtonItem:item
                                                                 otherButtonItems:nil];
            [alert showInController:self];
        }

        return isVaidate;
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:IBLSearchForHandleUserIdentifier]) {
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        searchViewController.viewModel = [IBLOperatorSearchViewModel operatorSearchModelWithOrder:nil
                                                                                       searchType:IBLSearchTypeAddOrderOperator];
        searchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:IBLSearchForProductIdentifier]){
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        IBLRegion *region = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeRegion];
        
        searchViewController.viewModel = [IBLProductSearchViewModel productSearchModelWithSearchType:IBLSearchTypeAddOrderProduct
                                                                                           productId:0
                                                                                            regionId:region.identifier];
        searchViewController.searchDelegate = self;
        
    }else if ([segue.identifier isEqualToString:IBLSearchForRegionIdentifier]){
        IBLSearchViewController *searchViewController = [segue destinationViewController];
        searchViewController.viewModel = [IBLRegionSearchViewModel regionSearchModelWithSearchType:IBLSearchTypeAddOrderArea];
        searchViewController.searchDelegate = self;
    }else if ([segue.identifier isEqualToString:IBLSearchForRelateUserIdentifier]){
        IBLUserSearchViewController *userSearchViewController = [segue destinationViewController];
        userSearchViewController.viewModel = [[IBLUserSearchViewModel alloc] initWithSearchType:IBLUserSearchTypeAddWorkOrder];
//                searchViewController.searchDelegate = self;
    }
}

- (void)setRelateUser:(IBLRelateUser *)relateUser{
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeRelateUser
                                       didEndEdit:relateUser];
    self.relateUserTextField.text = relateUser.account;
}

- (IBAction)relateUserSearchDidComplete:(UIStoryboardSegue *)segue{
    
}

- (void)searchViewController:(IBLSearchViewController *)searchViewController
           didSelectedResult:(id)searchResult {
    switch (searchViewController.viewModel.searchType) {
        case IBLSearchTypeAddOrderArea: {
            IBLRegion *region = searchResult;
            [self.tableViewDelegate addWorkOrderTableView:self
                                                fieldType:IBLAddWorkOrderFieldTypeRegion
                                               didEndEdit:searchResult];
            self.regionTextField.text = [region name];
            self.addressTextField.text = [region address];
            break;
        }
        case IBLSearchTypeAddOrderProduct: {
            IBLProduct *product = searchResult;
            [self.tableViewDelegate addWorkOrderTableView:self
                                                fieldType:IBLAddWorkOrderFieldTypeProduct
                                               didEndEdit:searchResult];
            self.productTextField.text = product.name;
            break;
        }
            
        case IBLSearchTypeAddOrderOperator: {
            IBLOperator *operator = searchResult;
            [self.tableViewDelegate addWorkOrderTableView:self
                                                fieldType:IBLAddWorkOrderFieldTypeHandleUser
                                               didEndEdit:searchResult];
            self.handleUserTextField.text = operator.name;
            break;
        }
        default: break;
    }
    
}


@end
