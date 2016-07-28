//
//  IBLAddWorkOrderTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAddWorkOrderTableViewController.h"
#import "IBLPickerView.h"

@interface IBLAddWorkOrderTableViewController ()
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
@property (weak, nonatomic) IBOutlet UITextField *workOrderContentTextField;
@property (weak, nonatomic) IBOutlet UITextField *relateUserTextField;
@property (weak, nonatomic) IBOutlet UITextField *handleUserTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end

@implementation IBLAddWorkOrderTableViewController

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
    
    return 40;
}

- (IBAction)workOrderBizTypeTapped:(UITapGestureRecognizer *)sender {
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

- (NSDictionary<NSIndexPath *, NSNumber* > *)hiddenFieldsDictionaryWithWorkBizType:(IBLWorkOrderBizStatus)bizType{
    NSDictionary *dic;
    
    switch (bizType) {
        case IBLWorkOrderBizStatusUnknow: {
            break;
        }
       
        case IBLWorkOrderBizStatusInstall: {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
