//
//  IBLOrderSearchViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewController.h"
#import "IBLMineOrderViewController.h"
#import "IBLOrderSearchViewModel.h"
#import "IBLPickerView.h"
#import <RMDateSelectionViewController/RMDateSelectionViewController.h>

@interface IBLOrderSearchViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *workOrderBizTypeTextField;

@property (weak, nonatomic) IBOutlet UITextField *workOrderTypeTextField;

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@end

@implementation IBLOrderSearchViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"现在"];
    [RMDateSelectionViewController setLocalizedTitleForCancelButton:@"取消"];
    [RMDateSelectionViewController setLocalizedTitleForSelectButton:@"选择"];
    self.usernameTextField.delegate = self;
    self.userAccountTextField.delegate = self;
    self.workOrderBizTypeTextField.delegate = self;
    self.workOrderTypeTextField.delegate = self;
}

- (IBAction)businessTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderBussinessType *> *businessTypes = [self.viewModel workOrderBizTypes];
    
    [IBLPickerView showPickerViewInView:self.view
                            withObjects:businessTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderBussinessType *workOrderBizType) {
                    return workOrderBizType.name;
                } completion:^(IBLWorkOrderBussinessType *workOrderBizType) {
                    [self.viewModel setWorkOrderBizType:workOrderBizType];
                    self.workOrderBizTypeTextField.text = workOrderBizType.name;
                }];
    

}

- (IBAction)workOrderTypeTaped:(UITapGestureRecognizer *)sender {
    NSArray<IBLWorkOrderType *> *workOrderTypes = [self.viewModel workOrderTypes];
    
    [IBLPickerView showPickerViewInView:self.view
                            withObjects:workOrderTypes
                            withOptions:nil
                objectToStringConverter:^NSString *(IBLWorkOrderType *workOrderType) {
                    return workOrderType.name;
                } completion:^(IBLWorkOrderType *businessType) {
                    [self.viewModel setWorkOrderType:businessType];
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
       self.startDateLabel.text = [aDate stringFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
        [self.viewModel setStartDate:self.startDateLabel.text];
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
        self.endDateLabel.text = [aDate stringFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
        [self.viewModel setEndDate:self.endDateLabel.text];
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        
    }];
}

- (void)saveUserOfSearchResult{
    [self.viewModel setUsername:self.usernameTextField.text];
    [self.viewModel setUserAccount:self.userAccountTextField.text];
    [self.viewModel setUserPhone:self.userPhoneTextField.text];
}
- (IBAction)searchButtonPressed:(UIButton *)sender {
    [self saveUserOfSearchResult];
    if ([self.delegate respondsToSelector:@selector(orderSearchViewController:didSearchResult:)]) {
        [self.delegate orderSearchViewController:self didSearchResult:self.viewModel.searchResult];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
