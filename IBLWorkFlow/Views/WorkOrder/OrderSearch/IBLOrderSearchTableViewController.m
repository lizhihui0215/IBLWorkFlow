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
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"现在"];
    [RMDateSelectionViewController setLocalizedTitleForCancelButton:@"取消"];
    [RMDateSelectionViewController setLocalizedTitleForSelectButton:@"选择"];
    
    self.userAccountTextField.text = [self.searchDataSource userAccount];
    self.usernameTextField.text = [self.searchDataSource username];
    self.userPhoneTextField.text = [self.searchDataSource userPhone];
    self.workOrderTypeTextField.text = [self.searchDataSource workOrderType];
    self.workOrderBizTypeTextField.text = [self.searchDataSource workOrderBizType];
    self.startDateTextField.text = [self.searchDataSource startDate];
    self.endDateTextField.text = [self.searchDataSource endDate];
    
}

- (IBAction)businessTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.searchDataSource workOrderBizTypes];
    
    [IBLPickerView showPickerViewInView:self.view.superview
                            withObjects:businessTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderBussinessType *workOrderBizType) {
                    return workOrderBizType.name;
                } completion:^(IBLWorkOrderBussinessType *workOrderBizType) {
                    [self.searchDataSource setWorkOrderBizType:workOrderBizType];
                    self.workOrderBizTypeTextField.text = workOrderBizType.name;
                }];
    

}

- (IBAction)workOrderTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderType *> *workOrderTypes = [self.searchDataSource workOrderTypes];
    
    [IBLPickerView showPickerViewInView:self.view.superview
                            withObjects:workOrderTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderType *workOrderType) {
                    return workOrderType.name;
                } completion:^(IBLWorkOrderType *businessType) {
                    [self.searchDataSource setWorkOrderType:businessType];
                    self.workOrderTypeTextField.text = businessType.name;
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
        [self.searchDataSource setStartDate:self.startDateTextField.text];
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
        [self.searchDataSource setEndDate:self.endDateTextField.text];
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
    }];
}

- (void)saveUserOfSearchResult{
    [self.searchDataSource setUsername:self.usernameTextField.text];
    [self.searchDataSource setUserAccount:self.userAccountTextField.text];
    [self.searchDataSource setUserPhone:self.userPhoneTextField.text];
}
- (IBAction)searchButtonPressed:(UIButton *)sender {
    [self saveUserOfSearchResult];
    [self.searchDataSource orderSearchViewController:self didSearchResult:self.searchDataSource.searchResult];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
