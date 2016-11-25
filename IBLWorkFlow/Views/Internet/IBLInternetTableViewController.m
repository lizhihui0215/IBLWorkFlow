//
//  IBLInternetTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 06/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLInternetTableViewController.h"
//#import <RMDateSelectionViewController/RMDateSelectionViewController.h>
#import "HcdDateTimePickerView.h"
#import "IBLInternetListViewController.h"

@interface IBLInternetTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@end

@implementation IBLInternetTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateTextField.text = [[NSDate date] stringFromFormatter:@"yyyy-MM"];
    
}
- (IBAction)dateTapped:(UITapGestureRecognizer *)sender {
    
    HcdDateTimePickerView *datePicker = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[NSDate dateWithTimeIntervalSinceNow:0]];
    [datePicker showHcdDateTimePicker];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datePicker.formatter = formatter;
    datePicker.clickedOkBtn = ^(NSString *time){
        self.dateTextField.text = time;//[aDate stringFromFormatter:@"yyyy-MM"];
    };

}

- (IBAction)searchButtonPressed:(UIButton *)sender {
//    IBLINternetListViewController *internetViewController = [IBLINternetListViewController]
    if ([NSString isNull:self.accountTextField.text]){
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确定"];
        
        
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                        title:@"请输入账号！"
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];
        return;
    }
    [self performSegueWithIdentifier:@"NavigationToInternetList" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"NavigationToInternetList"]){
        IBLInternetListViewController *internetViewController = [segue destinationViewController];
        internetViewController.viewModel = [[IBLInternetListViewModel alloc] initWithAccount:self.accountTextField.text
                                                                                        date:self.dateTextField.text];
    }
}


@end
