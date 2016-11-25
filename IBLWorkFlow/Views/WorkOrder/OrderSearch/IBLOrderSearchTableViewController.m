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

@interface IBLOrderSearchTableViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *workOrderBizTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *workOrderTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;

@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;

@end

@implementation IBLOrderSearchTableViewController

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
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IBLPickerView dismissWithCompletion:^(NSString *xx) {
        
    }];
}

- (IBAction)businessTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.searchDataSource workOrderBizTypesOfOrderSearchTableView:self ];
    if ([NSString isNull:self.workOrderTypeTextField.text]) {
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
        
        
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:@"请选择工单类型！"
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
        return;
    }
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (IBAction)startDateTaped:(UITapGestureRecognizer *)sender {
    
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateTimeMode defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    datePicker.formatter = formatter;
    [datePicker showHcdDateTimePicker];
    datePicker.clickedOkBtn = ^(NSString *time){
        self.startDateTextField.text = time;//[aDate stringFromFormatter:@"yyyy/MM/dd HH:mm:ss"];
        [self.searchDataSource orderSearchTableView:self
                                          fieldType:IBLOrderSearchFieldTypeStartDate
                                         didEndEdit:self.startDateTextField.text];
    };
}

- (IBAction)endDateTaped:(UITapGestureRecognizer *)sender {
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateTimeMode defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
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
}
- (IBAction)searchButtonPressed:(UIButton *)sender {
    [self saveUserOfSearchResult];
    [self.searchDataSource orderSearchTableviewDidEndSearch:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
