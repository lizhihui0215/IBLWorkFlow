//
//  IBLOrderSearchTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchTableViewController.h"
#import "IBLOrderViewController.h"
#import "IBLOrderSearchViewModel.h"
#import "IBLPickerView.h"
#import "HcdDateTimePickerView.h"
#import "IBLAppRepository.h"

@interface IBLOrderSearchTableViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *workOrderBizTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *workOrderTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;

@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *custTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseContactTextField;

@property (weak, nonatomic) IBOutlet UILabel *userTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseContact;
@property (weak, nonatomic) IBOutlet UILabel *bisTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation IBLOrderSearchTableViewController

- (NSDictionary <NSNumber *, NSString *> *)userTypeNames{
    return @{@(0) : @"一般用户",
             @(1) : @"企业用户"};
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.userAccountTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                             fieldType:IBLOrderSearchFieldTypeAccount];
    
    self.usernameTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                          fieldType:IBLOrderSearchFieldTypeUsername];
    
    self.userPhoneTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                           fieldType:IBLOrderSearchFieldTypePhone];
    
    self.workOrderTypeTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                               fieldType:IBLOrderSearchFieldTypeWorkOrderType];
    
    self.workOrderBizTypeTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                                  fieldType:IBLOrderSearchFieldTypeWorkOrderBizType];
    
    self.startDateTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                           fieldType:IBLOrderSearchFieldTypeStartDate];
    
    self.endDateTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                         fieldType:IBLOrderSearchFieldTypeEndDate];
    
    self.enterpriseNameTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                                fieldType:IBLOrderSearchFieldTypeEnterpriseName];
    
    self.enterpriseContactTextField.text = [self.searchDataSource textOfOrderSearchTableView:self
                                                                                   fieldType:IBLOrderSearchFieldTypeEnterpriseContact];
    
    
    NSNumber *custType = [self.searchDataSource textOfOrderSearchTableView:self
                                                                 fieldType:IBLOrderSearchFieldTypeCustType];
    
    self.custTypeTextField.text = [self userTypeNames][custType];
}

- (void)languageDidChanged:(NSNotification *)notification{
    self.userTypeLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.userTypeLabel.title", @"Main", "not found");
    self.accountLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.accountLabel.title", @"Main", "not found");
    self.usernameLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.usernameLabel.title", @"Main", "not found");
    self.phoneLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.phoneLabel.title", @"Main", "not found");
    self.enterpriseLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.enterpriseLabel.title", @"Main", "not found");
    self.enterpriseContact.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.enterpriseContact.title", @"Main", "not found");
    self.bisTypeLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.bisTypeLabel.title", @"Main", "not found");
    self.startDateLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.startDateLabel.title", @"Main", "not found");
    self.endDateLabel.text = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.endDateLabel.title", @"Main", "not found");
    
    [self.searchButton setTitle:NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.searchButton.title", @"Main", "not found") forState:UIControlStateNormal];
    
    
    
    
    self.userAccountTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.userAccountTextField.placeholder", @"Main", "not found");
    self.usernameTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.usernameTextField.placeholder", @"Main", "not found");
    self.userPhoneTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.userPhoneTextField.placeholder", @"Main", "not found");
    self.workOrderBizTypeTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.workOrderBizTypeTextField.placeholder", @"Main", "not found");
    self.workOrderTypeTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.workOrderTypeTextField.placeholder", @"Main", "not found");
    self.startDateTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.startDateTextField.placeholder", @"Main", "not found");
    self.endDateTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.endDateTextField.placeholder", @"Main", "not found");
    self.custTypeTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.custTypeTextField.placeholder", @"Main", "not found");
    self.enterpriseNameTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.enterpriseNameTextField.placeholder", @"Main", "not found");
    self.enterpriseContactTextField.placeholder = NSLocalizedStringFromTable(@"IBLOrderSearchTableViewController.enterpriseContactTextField.placeholder", @"Main", "not found");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IBLPickerView dismissWithCompletion:^(NSString *xx) {
        
    }];
}

- (IBAction)businessTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.searchDataSource workOrderBizTypesOfOrderSearchTableView:self];
//    if ([NSString isNull:self.workOrderTypeTextField.text]) {
//        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
//        
//        
//        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
//                                                                        title:@"请选择工单类型！"
//                                                                      message:nil
//                                                             cancleButtonItem:cancel
//                                                             otherButtonItems:nil];
//        [alert showInController:self];
//        return;
//    }
    [IBLPickerView showPickerViewInView:self.view.superview
                            withObjects:businessTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderBussinessType *workOrderBizType) {
                    return workOrderBizType.name;
                } completion:^(IBLWorkOrderBussinessType *workOrderBizType) {
                    [self.searchDataSource orderSearchTableView:self
                                                      fieldType:IBLOrderSearchFieldTypeWorkOrderBizType
                                                     didEndEdit:workOrderBizType];
                    self.workOrderBizTypeTextField.text = workOrderBizType.name;
                }];
    
    
}

- (IBAction)workOrderTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderType *> *workOrderTypes = [self.searchDataSource workOrderTypesOfOrderSearchTableView:self];
    
    [IBLPickerView showPickerViewInView:self.view.superview
                            withObjects:workOrderTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderType *workOrderType) {
                    return workOrderType.name;
                } completion:^(IBLWorkOrderType *workOrderType) {
                    [self.searchDataSource orderSearchTableView:self
                                                      fieldType:IBLOrderSearchFieldTypeWorkOrderType
                                                     didEndEdit:workOrderType];
                    
                    self.workOrderTypeTextField.text = workOrderType.name;
                    
                    
                    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.searchDataSource workOrderBizTypesOfOrderSearchTableView:self];
                    
                    IBLWorkOrderBussinessType *first = businessTypes.firstObject;
                    [self.searchDataSource orderSearchTableView:self
                                                      fieldType:IBLOrderSearchFieldTypeWorkOrderBizType
                                                     didEndEdit:first];
                    self.workOrderBizTypeTextField.text = first.name;
                }];
}

- (IBAction)custTypeTapped:(UITapGestureRecognizer *)sender {
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
                                                  [self.searchDataSource orderSearchTableView:self
                                                                                    fieldType:IBLOrderSearchFieldTypeCustType
                                                                                   didEndEdit:@(index)];
                                                  self.custTypeTextField.text = [self userTypeNames][@(index)];
                                                  [self.tableView reloadData];
                                              }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (IBAction)startDateTaped:(UITapGestureRecognizer *)sender {
    
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datePicker.formatter = formatter;
    [datePicker showHcdDateTimePicker];
    datePicker.clickedOkBtn = ^(NSString *time){
        self.startDateTextField.text = time;//[aDate stringFromFormatter:@"yyyy/MM/dd HH:mm:ss"];
        [self.searchDataSource orderSearchTableView:self
                                          fieldType:IBLOrderSearchFieldTypeStartDate
                                         didEndEdit:self.startDateTextField.text];
    };
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isHiddenAtIndexPath:indexPath]) return 0;
    return 40;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)path {
    NSInteger custType = [[self.searchDataSource textOfOrderSearchTableView:self fieldType:IBLOrderSearchFieldTypeCustType] integerValue];
    
    NSMutableArray *hiddenIndexPath = nil;
        
    if (custType == 0) {
        NSIndexPath *enterpriseNameIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        NSIndexPath *enterpriseContactIndexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        hiddenIndexPath = [@[enterpriseNameIndexPath,
                            enterpriseContactIndexPath] mutableCopy];
    }else{
        NSIndexPath *usernameIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        NSIndexPath *userPhoneIndexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        hiddenIndexPath = [@[usernameIndexPath,
                            userPhoneIndexPath] mutableCopy];
    }
    
//    if (![[PCCWLocalized defaultLocalized].preferredLanguage isEqualToString:@"zh"]) {
//        NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [hiddenIndexPath addObject:userTypeIndexPath];
//    }
    
    
    NSIndexPath *userTypeIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    if ([IBLAppRepository appConfiguration].showCustType == 0) {
        [hiddenIndexPath addObject:userTypeIndexPath];
    }
    
    return [hiddenIndexPath containsObject:path];
}

- (IBAction)endDateTaped:(UITapGestureRecognizer *)sender {
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datePicker.formatter = formatter;
    [datePicker showHcdDateTimePicker];
    datePicker.clickedOkBtn = ^(NSString *time){
        self.endDateTextField.text = time;
        [self.searchDataSource orderSearchTableView:self
                                          fieldType:IBLOrderSearchFieldTypeEndDate
                                         didEndEdit:self.endDateTextField.text];
    };
}

- (void)saveUserOfSearchResult{
    [self.searchDataSource orderSearchTableView:self
                                      fieldType:IBLOrderSearchFieldTypeUsername
                                     didEndEdit:self.usernameTextField.text];
    [self.searchDataSource orderSearchTableView:self
                                      fieldType:IBLOrderSearchFieldTypeAccount
                                     didEndEdit:self.userAccountTextField.text];
    [self.searchDataSource orderSearchTableView:self
                                      fieldType:IBLOrderSearchFieldTypePhone
                                     didEndEdit:self.userPhoneTextField.text];
    
    [self.searchDataSource orderSearchTableView:self
                                      fieldType:IBLOrderSearchFieldTypeEnterpriseName
                                     didEndEdit:self.enterpriseNameTextField.text];
    
    [self.searchDataSource orderSearchTableView:self
                                      fieldType:IBLOrderSearchFieldTypeEnterpriseContact
                                     didEndEdit:self.enterpriseContactTextField.text];
}
- (IBAction)searchButtonPressed:(UIButton *)sender {
    [self saveUserOfSearchResult];
    [self.searchDataSource orderSearchTableviewDidEndSearch:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
