//
//  IBLAddWorkOrderViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAddWorkOrderViewController.h"
#import "IBLAddWorkOrderTableViewController.h"
#import "IBLRegion.h"
#import "IBLProduct.h"
#import "IBLRelateUser.h"
#import "IBLOperator.h"
#import "IBLException.h"

@interface IBLAddWorkOrderViewController () <IBLAddWorkOrderTableViewControllerDelegate>

@end

@implementation IBLAddWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
   IBLAddWorkOrderTableViewController *addWorkOrderTableViewController = [segue destinationViewController];
    addWorkOrderTableViewController.tableViewDelegate = self;
}

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesOfTableView:(IBLAddWorkOrderTableViewController *)controller {
    return [self.viewModel workOrderBizTypes];
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypesOfTableView:(IBLAddWorkOrderTableViewController *)controller {
    return [self.viewModel workOrderTypes];
}

- (void)addWorkOrderTableView:(IBLAddWorkOrderTableViewController *)controller fieldType:(IBLAddWorkOrderFieldType)type didEndEdit:(id)obj {
    switch (type) {
        case IBLAddWorkOrderFieldTypeWorkOrderType: {
            [self.viewModel setWorkOrderType:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeBizType: {
            [self.viewModel setWorkOrderBizType:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypePriority: {
            [self.viewModel setPriority:[obj integerValue]];
            break;
        }
        case IBLAddWorkOrderFieldTypeFinishedDate: {
            [self.viewModel setFinishedDate:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeRegion: {
            [self.viewModel setRegion:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeProduct: {
            [self.viewModel setProduct:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeCount: {
            [self.viewModel setCount:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeUsername: {
            [self.viewModel setUsername:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypePhone: {
            [self.viewModel setPhone:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeAddress: {
            [self.viewModel setAddress:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeUserIdentifier: {
            [self.viewModel setUserIdentifier:[obj integerValue]];
            break;
        }
        case IBLAddWorkOrderFieldTypeWorkOrderContent: {
            [self.viewModel setWorkOrderContent:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeRelateUser: {
            [self.viewModel setRelateUser:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeHandleUser: {
            [self.viewModel setOperator:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeRemark: {
            [self.viewModel setRemark:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeCustType: {
            [self.viewModel setCustType:[obj integerValue]];
            break;
        }
        case IBLAddWorkOrderFieldTypeCertType: {
            [self.viewModel setCertType:[obj integerValue]];
            break;
        }
        case IBLAddWorkOrderFieldTypeEnterpriseName:{

            [self.viewModel setEnterpriseName:obj];
            break;
        }
        case IBLAddWorkOrderFieldTypeEnterpriseSampleName:{
            [self.viewModel setEnterpriseSample:obj];
            break;

        }
        case IBLAddWorkOrderFieldTypeEnterpriseContact:{
            [self.viewModel setEnterpriseContact:obj];
            break;

        }
        case IBLAddWorkOrderFieldTypeEnterpriseContactPhone:{
            [self.viewModel setEnterpriseContactPhone:obj];
            break;

        }
        case IBLAddWorkOrderFieldTypeEnterpriseAddress:{
            [self.viewModel setEnterpriseAddress:obj];
            break;

        }
    }
}

- (id)fieldOfAddWorkOrderTableView:(IBLAddWorkOrderTableViewController *)controller
                         fieldType:(IBLAddWorkOrderFieldType)type {
    id obj = nil;
    switch (type) {
        case IBLAddWorkOrderFieldTypeWorkOrderType: {
           obj = [self.viewModel workOrderType];
            break;
        }
        case IBLAddWorkOrderFieldTypeBizType: {
            obj = [self.viewModel workOrderBizType];
            break;
        }
        case IBLAddWorkOrderFieldTypeRegion:{
            obj = self.viewModel.region;
            break;
        }
        case IBLAddWorkOrderFieldTypeCustType: {
            NSInteger custType = [self.viewModel custType];
            obj = @(custType);
            break;
        }
        case IBLAddWorkOrderFieldTypeCertType:{
            NSInteger certType = [self.viewModel certType];
            obj = @(certType);
            break;
        }
        default:
            break;
    }
    
    return obj;
}

- (void)addWorkOrderTableDidCommit:(IBLAddWorkOrderTableViewController *)controller {
    [self showHUDWithMessage:@"提交中..."];
    @weakify(self)
    [self.viewModel commitWithCompleteHandler:^(NSError *error){
        @strongify(self)
        [self hidHUD];
        if (![self showAlertWithError:error]) {
            NSError *error = [NSError errorWithDomain:@""
                                                 code:0 userInfo:@{kExceptionCode : @(0),
                                                                   kExceptionMessage : @"新增成功！"}];
            [self showAlertWithError:error
                     completeHandler:^(BOOL isShowError, NSError *error) {
                         [self.delegate addWorkOrderTableDidCommit:self];
                     }];
        }
    }];
}


@end
