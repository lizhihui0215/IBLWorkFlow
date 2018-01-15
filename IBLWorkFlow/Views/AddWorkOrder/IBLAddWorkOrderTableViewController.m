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
#import "IBLAppRepository.h"


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
@property (weak, nonatomic) IBOutlet UITextField *certTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *custTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseSampleTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseAddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *relateUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *handleUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *adviceUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UITextField *adviceUserPhoneTextField;

@end

@implementation IBLAddWorkOrderTableViewController

- (IBAction)priorityTapped:(UITapGestureRecognizer *)sender {
    NSArray *options = @[@"紧急", @"一般", @"不紧急"];
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择优先级"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:options
                    popoverPresentationControllerBlock:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                  if (buttonIndex == [controller cancelButtonIndex]) return;
                                                  NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                                                  NSInteger index = buttonIndex - firstOtherIndex;
                                                  
                                                  
                                                  if (index == 0) {
                                                      [self.tableViewDelegate addWorkOrderTableView:self
                                                                                          fieldType:IBLAddWorkOrderFieldTypePriority
                                                                                         didEndEdit:@(IBLPriorityStatusEmergency)];
                                                  }else if (index == 1) {
                                                      [self.tableViewDelegate addWorkOrderTableView:self
                                                                                          fieldType:IBLAddWorkOrderFieldTypePriority
                                                                                         didEndEdit:@(IBLPriorityStatusGeneral)];
                                                  }else if (index == 2) {
                                                      [self.tableViewDelegate addWorkOrderTableView:self
                                                                                          fieldType:IBLAddWorkOrderFieldTypePriority
                                                                                         didEndEdit:@(IBLPriorityStatusNoEmergency)];
                                                  }
                                                  self.priorityTextField.text = options[index];
                                              }];
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
                                                                        kExceptionMessage : @"请选择区域!"}];
        
        [self showAlertWithError:error];
        return;
    }
    
    [self performSegueWithIdentifier:IBLSearchForProductIdentifier sender:self];
    
}
- (IBAction)regionTapped:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:IBLSearchForRegionIdentifier sender:self];
}

- (IBAction)workOrderBizTypeTapped:(UITapGestureRecognizer *)sender {
    
    //    IBLWorkOrderType *workOrderType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeWorkOrderType];
    //
    //    if (!workOrderType) {
    //        NSError *error = [NSError errorWithDomain:@""
    //                                             code:0
    //                                         userInfo:@{kExceptionCode : @(-1),
    //                                                    kExceptionMessage: @"请选择工单类型！"}];
    //        [self showAlertWithError:error];
    //        return;
    //    }
    
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
- (IBAction)custTypeTapped:(UITapGestureRecognizer *)sender {
    NSArray *options = @[@"一般用户", @"企业用户"];
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择用户类型"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:options
                    popoverPresentationControllerBlock:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                  if (buttonIndex == [controller cancelButtonIndex]) return;
                                                  NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                                                  NSInteger index = buttonIndex - firstOtherIndex;
                                                  if (index == 0) {
                                                      [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCustType didEndEdit:@(0)];
                                                      self.custTypeTextField.text = [self userTypeNames][@(0)];
                                                      [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCertType didEndEdit:@(0)];
                                                      self.certTypeTextField.text = [self certTypeNames][@(0)];
                                                  }else if (index == 1) {
                                                      [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCustType didEndEdit:@(1)];
                                                      self.custTypeTextField.text = [self userTypeNames][@(1)];
                                                      [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCertType didEndEdit:@(6)];
                                                      self.certTypeTextField.text = [self certTypeNames][@(6)];
                                                  }
                                                  [self cleanUserInfo];
                                                  
                                                  [self.tableView reloadData];
                                              }];
    
    
}

- (void)cleanUserInfo{
    self.usernameTextField.text = nil;
    self.phoneTextField.text = nil;
    self.addressTextField.text = nil;
    self.enterpriseNameTextField.text = nil;
    self.enterpriseSampleTextField.text = nil;
    self.enterpriseContactPhoneTextField.text = nil;
    self.enterpriseContactTextField.text = nil;
    self.enterpriseAddressTextField.text = nil;
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeUsername didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypePhone didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeAddress didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeEnterpriseName didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeEnterpriseAddress didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeEnterpriseContact didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeEnterpriseSampleName didEndEdit:nil];
    [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeEnterpriseContactPhone didEndEdit:nil];
}

- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(0) : @"一般用户",
             @(1) : @"企业用户"};
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    IBLWorkOrderBussinessType *bizType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeBizType];
    
    if ([[self hiddenFieldsDictionaryWithWorkBizType:bizType.status][indexPath] boolValue]) return 0;
    
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:22 inSection:0]]) return 87;
    
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:19 inSection:0]]) return 98;
    
    return 40;
}

- (IBAction)certTypeTapped:(UITapGestureRecognizer *)sender {
    [UIAlertController showActionSheetInViewController:self
                                             withTitle:@"请选择证件号码"
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@[@"身份证", @"驾照", @"护照", @"回乡证", @"台胞证", @"其它", @"营业执照"]
                    popoverPresentationControllerBlock:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                  if (buttonIndex == [controller cancelButtonIndex]) return;
                                                  NSInteger firstOtherIndex = [controller firstOtherButtonIndex];
                                                  NSInteger index = buttonIndex - firstOtherIndex;
                                                  [self.tableViewDelegate addWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCertType didEndEdit:@(index)];
                                                  self.certTypeTextField.text = [self certTypeNames][@(index)];
                                                  [self.tableView reloadData];
                                              }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}



- (NSDictionary<NSIndexPath *, NSNumber* > *)hiddenFieldsDictionaryWithWorkBizType:(IBLWorkOrderBizStatus)bizType{
    NSDictionary *dic;
    switch (bizType) {
        case IBLWorkOrderBizStatusUnknow: {
            break;
        }
            
        case IBLWorkOrderBizStatusInstall: {
            NSInteger custType = [[self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCustType] integerValue];
            NSMutableDictionary *hiddenIndexPaths = [NSMutableDictionary dictionary];
            
            if (custType == 0){
                NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
                NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:13 inSection:0];
                NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
                NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:15 inSection:0];
                NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:16 inSection:0];
                
                [hiddenIndexPaths addEntriesFromDictionary:@{enterpriseNameIndexPath : @(YES),
                                                             enterpriseSampleNameIndexPath : @(YES),
                                                             enterpriseContactIndexPath : @(YES),
                                                             enterprisePhoneIndexPath : @(YES),
                                                             enterpriseAddressIndexPath : @(YES)}];
                
            }else {
                NSIndexPath *usernameTextField = [NSIndexPath indexPathForRow:9 inSection:0];
                NSIndexPath *userPhone = [NSIndexPath indexPathForRow:10 inSection:0];
                NSIndexPath *userAddress = [NSIndexPath indexPathForRow:11 inSection:0];
                [hiddenIndexPaths addEntriesFromDictionary:@{usernameTextField : @(YES),
                                                             userPhone : @(YES),
                                                             userAddress : @(YES),}];
                
            }
            NSIndexPath *adviceUserNameIndexPath = [NSIndexPath indexPathForRow:17 inSection:0];
            NSIndexPath *adviceUserPhoneIndexPath = [NSIndexPath indexPathForRow:18 inSection:0];
            
            
            NSIndexPath *indexPathWorkOrderContent = [NSIndexPath indexPathForRow:19 inSection:0];
            NSIndexPath *indexPathRelateUser = [NSIndexPath indexPathForRow:20 inSection:0];
            [hiddenIndexPaths addEntriesFromDictionary:@{indexPathWorkOrderContent : @(YES),
                                                         indexPathRelateUser : @(YES),
                                                         adviceUserPhoneIndexPath : @(YES),
                                                         adviceUserNameIndexPath: @(YES)}];
            
            NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            
            if ([IBLAppRepository appConfiguration].showCustType == 0) {
                [hiddenIndexPaths addEntriesFromDictionary:@{userTypeIndexPath : @(YES)}];
            }
            
            dic = hiddenIndexPaths;
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
            NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            
            NSIndexPath *productIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            NSIndexPath *countIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            NSIndexPath *certTypeIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            NSIndexPath *userIdentifierIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
            NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
            NSIndexPath *phoneIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
            NSIndexPath *addressIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
            
            NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
            NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:13 inSection:0];
            NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
            NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:15 inSection:0];
            NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:16 inSection:0];
            
            NSIndexPath *relateUserIndexPath = [NSIndexPath indexPathForRow:20 inSection:0];
            NSIndexPath *remarkIndexPath = [NSIndexPath indexPathForRow:22 inSection:0];
            NSIndexPath *adviceUserNameIndexPath = [NSIndexPath indexPathForRow:17 inSection:0];
            NSIndexPath *adviceUserPhoneIndexPath = [NSIndexPath indexPathForRow:18 inSection:0];
            
            dic = @{productIndexPath : @(YES),
                    countIndexPath : @(YES),
                    usernameIndexPath : @(YES),
                    phoneIndexPath : @(YES),
                    addressIndexPath : @(YES),
                    userIdentifierIndexPath : @(YES),
                    relateUserIndexPath : @(YES),
                    remarkIndexPath : @(YES),
                    certTypeIndexPath: @(YES),
                    enterpriseNameIndexPath: @(YES),
                    enterpriseSampleNameIndexPath: @(YES),
                    enterpriseContactIndexPath: @(YES),
                    enterprisePhoneIndexPath: @(YES),
                    enterpriseAddressIndexPath: @(YES),
                    userTypeIndexPath: @(YES),
                    userTypeIndexPath: @(YES),
                    adviceUserPhoneIndexPath : @(YES),
                    adviceUserNameIndexPath: @(YES)};
            break;
        }
        case IBLWorkOrderBizStatusHandleAdvisory: {
            NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            
            NSIndexPath *productIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            NSIndexPath *countIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
            NSIndexPath *phoneIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
            NSIndexPath *addressIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
            
            NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
            NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:13 inSection:0];
            NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
            NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:15 inSection:0];
            NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:16 inSection:0];
            NSIndexPath *userIdentifierIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
            NSIndexPath *certTypeIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            NSIndexPath *remarkIndexPath = [NSIndexPath indexPathForRow:22 inSection:0];
            dic = @{productIndexPath : @(YES),
                    countIndexPath : @(YES),
                    usernameIndexPath : @(YES),
                    phoneIndexPath : @(YES),
                    addressIndexPath : @(YES),
                    userIdentifierIndexPath : @(YES),
                    enterpriseNameIndexPath : @(YES),
                    enterpriseSampleNameIndexPath : @(YES),
                    enterpriseContactIndexPath : @(YES),
                    enterprisePhoneIndexPath : @(YES),
                    enterpriseAddressIndexPath : @(YES),
                    certTypeIndexPath : @(YES),
                    remarkIndexPath : @(YES),
                    userTypeIndexPath: @(YES)};
            
            break;
        }
        default:{
            NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            
            NSIndexPath *regionIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
            NSIndexPath *productIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            NSIndexPath *countIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
            NSIndexPath *phoneIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
            NSIndexPath *addressIndexPath = [NSIndexPath indexPathForRow:11 inSection:0];
            
            NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:12 inSection:0];
            NSIndexPath *enterpriseSampleNameIndexPath = [NSIndexPath indexPathForRow:13 inSection:0];
            NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:14 inSection:0];
            NSIndexPath *enterprisePhoneIndexPath = [NSIndexPath indexPathForRow:15 inSection:0];
            NSIndexPath *enterpriseAddressIndexPath = [NSIndexPath indexPathForRow:16 inSection:0];
            NSIndexPath *certTypeIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            
            NSIndexPath *userIdentifierIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
            NSIndexPath *remarkIndexPath = [NSIndexPath indexPathForRow:22 inSection:0];
            NSIndexPath *adviceUserNameIndexPath = [NSIndexPath indexPathForRow:17 inSection:0];
            NSIndexPath *adviceUserPhoneIndexPath = [NSIndexPath indexPathForRow:18 inSection:0];
            
            
            dic = @{regionIndexPath : @(YES),
                    productIndexPath : @(YES),
                    countIndexPath : @(YES),
                    usernameIndexPath : @(YES),
                    phoneIndexPath : @(YES),
                    addressIndexPath : @(YES),
                    userIdentifierIndexPath : @(YES),
                    enterpriseNameIndexPath : @(YES),
                    enterpriseSampleNameIndexPath : @(YES),
                    enterpriseContactIndexPath : @(YES),
                    enterprisePhoneIndexPath : @(YES),
                    enterpriseAddressIndexPath : @(YES),
                    certTypeIndexPath : @(YES),
                    remarkIndexPath : @(YES),
                    userTypeIndexPath: @(YES),
                    adviceUserPhoneIndexPath : @(YES),
                    adviceUserNameIndexPath: @(YES)};
            break;
        }
    }
    return dic;
}



- (NSString *)validateContents{
    NSString *title = nil;
    IBLWorkOrderBussinessType *type = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeBizType];
    
    NSNumber *custType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self
                                                                    fieldType:IBLAddWorkOrderFieldTypeCustType];
    
    //    if([NSString isNull:self.workOrderTypeTextField.text]){
    //        title = @"请选择工单类型！";
    //    };
    
    if([NSString isNull:self.workOrderBizTypeTextField.text]){
        title = @"请选择业务类型！";
    };
    
    if (type.status == IBLWorkOrderBizStatusInstall) {
        if([NSString isNull:self.regionTextField.text]){
            title = @"请选择区域！";
        };
        
        
        if ([custType integerValue] == 0) {
            if(![IBLUtilities validateMobile:self.phoneTextField.text]){
                title = @"您输入的手机格式不正确！";
            };
        }else{
            if(![IBLUtilities validateMobile:self.enterpriseContactPhoneTextField.text]){
                title = @"您输入的手机格式不正确！";
            };
        }
    }else if (type.status == IBLWorkOrderBizStatusHandleAdvisory){
        if([NSString isNull:self.regionTextField.text] && ([NSString isNull:self.relateUserTextField.text])){
            title = @"请选择区域或者关联用户！";
        };
        
    }else{
        if([NSString isNull:self.relateUserTextField.text]){
            title = @"请选择关联用户！";
        }
        
        if ([self.productCountTextField.text integerValue] <= 0) {
            title = @"订购数量必须大于0！";
        }
    }
    
    
    
    return title;
}

- (IBAction)commitTapped:(UIButton *)sender {
    NSString *title = [self validateContents];
    if (![NSString isNull:title]) {
        [self showAlertWithError:errorWithCode(0, title)];
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
    
    NSString *enterpriseName = [self validateContent:self.enterpriseNameTextField.text];
    NSString *enterpriseSampleName = [self validateContent:self.enterpriseSampleTextField.text];
    NSString *enterpriseContact = [self validateContent:self.enterpriseContactTextField.text];
    NSString *enterpriseContactPhone = [self validateContent:self.enterpriseContactPhoneTextField.text];
    NSString *enterpriseAddress = [self validateContent:self.enterpriseAddressTextField.text];
    
    NSString *adviceUsername = [self validateContent:self.adviceUserNameTextField.text];
    NSString *adviceUserPhone = [self validateContent:self.adviceUserPhoneTextField.text];
    
    IBLWorkOrderBussinessType *type = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeBizType];
    
    if (type.status == IBLWorkOrderBizStatusHandleAdvisory) {
        [self.tableViewDelegate addWorkOrderTableView:self
                                            fieldType:IBLAddWorkOrderFieldTypeUsername
                                           didEndEdit:adviceUsername];
        [self.tableViewDelegate addWorkOrderTableView:self
                                            fieldType:IBLAddWorkOrderFieldTypePhone
                                           didEndEdit:adviceUserPhone];
    }else {
        [self.tableViewDelegate addWorkOrderTableView:self
                                            fieldType:IBLAddWorkOrderFieldTypeUsername
                                           didEndEdit:username];
        [self.tableViewDelegate addWorkOrderTableView:self
                                            fieldType:IBLAddWorkOrderFieldTypePhone
                                           didEndEdit:phone];
    }
    
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
    
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeEnterpriseName
                                       didEndEdit:enterpriseName];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeEnterpriseSampleName
                                       didEndEdit:enterpriseSampleName];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeEnterpriseContact
                                       didEndEdit:enterpriseContact];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeEnterpriseContactPhone
                                       didEndEdit:enterpriseContactPhone];
    [self.tableViewDelegate addWorkOrderTableView:self
                                        fieldType:IBLAddWorkOrderFieldTypeEnterpriseAddress
                                       didEndEdit:enterpriseAddress];
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
    self.enterpriseContactPhoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.userIdentifierTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.productCountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.adviceUserPhoneTextField.keyboardType = UIKeyboardTypePhonePad;
    
    [self.phoneTextField setBk_shouldEndEditingBlock:^BOOL(UITextField *textField) {
        BOOL isVaidate = [IBLUtilities validateMobile:textField.text];
        if (!isVaidate) {
            [self showAlertWithError:errorWithCode(0, @"电话号码格式不正确！")];
        }
        
        return isVaidate;
    }];
    
    
    [self.enterpriseContactPhoneTextField setBk_shouldEndEditingBlock:^BOOL(UITextField *textField) {
        BOOL isVaidate = [IBLUtilities validateMobile:textField.text];
        if (!isVaidate) {
            [self showAlertWithError:errorWithCode(0, @"电话号码格式不正确！")];
        }
        return isVaidate;
    }];
    
    [self.adviceUserPhoneTextField setBk_shouldEndEditingBlock:^BOOL(UITextField *textField) {
        BOOL isVaidate = [IBLUtilities validateMobile:textField.text];
        if (!isVaidate) {
            [self showAlertWithError:errorWithCode(0, @"电话号码格式不正确！")];
        }
        
        return isVaidate;
    }];
    
    
    
    //    self.custTypeTextField.text =
    NSInteger custType = [[self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCustType] integerValue];
    self.custTypeTextField.text = [self userTypeNames][@(custType)];
    
    
    NSNumber *certType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCertType];
    
    self.certTypeTextField.text = [self certTypeNames][certType];
    
    
    
    
    [self.userIdentifierTextField setBk_shouldEndEditingBlock:^BOOL(UITextField *textField) {
        NSNumber *certType = [self.tableViewDelegate fieldOfAddWorkOrderTableView:self fieldType:IBLAddWorkOrderFieldTypeCertType];
        
        if ([certType integerValue] != 0) return YES;
        
        BOOL isVaidate = [IBLUtilities validateIdentityCard:textField.text];
        if (!isVaidate) {
            [self showAlertWithError:errorWithCode(0, @"身份证号码格式不正确！")];
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
