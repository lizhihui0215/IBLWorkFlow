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
#import <RMDateSelectionViewController/RMDateSelectionViewController.h>

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



- (IBAction)businessTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.searchDataSource workOrderBizTypesOfOrderSearchTableView:self ];
    
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
                }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
   
}

- (IBAction)startDateTaped:(UITapGestureRecognizer *)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.disableBouncingWhenShowing = YES;
    dateSelectionVC.datePicker.minuteInterval = 1;
    
    dateSelectionVC.disableBlurEffects = YES;
    
    dateSelectionVC.hideNowButton = YES;
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        self.startDateTextField.text = [aDate stringFromFormatter:@"yyyy/MM/dd HH:mm:ss"];
        [self.searchDataSource orderSearchTableView:self
                                          fieldType:IBLOrderSearchFieldTypeStartDate
                                         didEndEdit:self.startDateTextField.text];
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
    }];
}

- (IBAction)endDateTaped:(UITapGestureRecognizer *)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.disableBouncingWhenShowing = YES;
    dateSelectionVC.datePicker.minuteInterval = 1;
    
    dateSelectionVC.disableBlurEffects = YES;
    
    dateSelectionVC.hideNowButton = YES;
    
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        self.endDateTextField.text = [aDate stringFromFormatter:@"yyyy/MM/dd HH:mm:ss"];
        [self.searchDataSource orderSearchTableView:self
                                          fieldType:IBLOrderSearchFieldTypeEndDate
                                         didEndEdit:self.endDateTextField.text];
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
    }];
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
