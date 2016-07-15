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
#import <RMDateSelectionViewController/RMDateSelectionViewController.h>

@interface IBLOrderSearchViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userAccountTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *businessTypeTextField;

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
    self.businessTypeTextField.delegate = self;
    self.workOrderTypeTextField.delegate = self;
}

- (IBAction)businessTypeTaped:(UITapGestureRecognizer *)sender {
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
    
//    [self.viewModel setBusinessType:textField.text];

    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                    title:@"请选择业务类型"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                          otherButtonItems:nil];
    [alert showInController:self];
}

- (IBAction)workOrderTypeTaped:(UITapGestureRecognizer *)sender {
    IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"取消"];
    
//    [self.viewModel setWorkOrderType:textField.text];

    
    IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                    title:@"请选工单类型"
                                                                  message:nil
                                                         cancleButtonItem:cancel
                                                         otherButtonItems:nil];
    [alert showInController:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.usernameTextField == textField) {
        [self.viewModel setUsername:textField.text];
    }
    
    if (self.userAccountTextField == textField) {
        [self.viewModel setUserAccount:textField.text];
    }
    if (self.userPhoneTextField == textField) {
        [self.viewModel setUserPhone:textField.text];
    }
   
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

- (IBAction)searchButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(orderSearchViewController:didSearchResult:)]) {
        [self.delegate orderSearchViewController:self didSearchResult:self.viewModel.searchResult];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
