//
//  IBLOrderSearchViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderSearchViewController.h"
#import "IBLOrderCell.h"

@interface IBLOrderSearchViewController ()<IBLOrderSearchTableViewControllerDataSource>

@property (nonatomic, weak) IBLOrderSearchTableViewController *tableViewController;

@end

@implementation IBLOrderSearchViewController

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
    IBLOrderSearchTableViewController *orderSearchTableViewController = [segue destinationViewController];
    orderSearchTableViewController.searchDataSource = self;
}

- (id)textOfOrderSearchTableView:(IBLOrderSearchTableViewController *)controller
                       fieldType:(IBLOrderSearchFieldType)fieldType {
    NSString *text = @"";
    switch (fieldType) {
        case IBLOrderSearchFieldTypeAccount: {
            text = [self.viewModel userAccount];
            break;
        }
        case IBLOrderSearchFieldTypeUsername: {
            text = [self.viewModel username];
            break;
        }
        case IBLOrderSearchFieldTypePhone: {
            text = [self.viewModel userPhone];
            break;
        }
        case IBLOrderSearchFieldTypeWorkOrderBizType: {
            text = [self.viewModel workOrderBizType];
            break;
        }
        case IBLOrderSearchFieldTypeWorkOrderType: {
            text = [self.viewModel workOrderType];
            break;
        }
        case IBLOrderSearchFieldTypeStartDate: {
            text = [self.viewModel startDate];
            break;
        }
        case IBLOrderSearchFieldTypeEndDate: {
            text = [self.viewModel endDate];
            break;
        }
        case IBLOrderSearchFieldTypeCustType: {
            return @([self.viewModel custType]);
        }
        case IBLOrderSearchFieldTypeEnterpriseName:{
            text = [self.viewModel enterPriseName];
            break;
        }
        case IBLOrderSearchFieldTypeEnterpriseContact:{
            text = [self.viewModel enterpriseContact];
            break;
        }
    }
    return text;
}

- (void)orderSearchTableView:(IBLOrderSearchTableViewController *)controller
                   fieldType:(IBLOrderSearchFieldType)type
                  didEndEdit:(id)object {
    switch (type) {
        case IBLOrderSearchFieldTypeAccount: {
            [self.viewModel setUserAccount:object];
            break;
        }
        case IBLOrderSearchFieldTypeUsername: {
            [self.viewModel setUsername:object];
            break;
        }
        case IBLOrderSearchFieldTypePhone: {
            [self.viewModel setUserPhone:object];
            break;
        }
        case IBLOrderSearchFieldTypeWorkOrderBizType: {
            [self.viewModel setWorkOrderBizType:object];
            break;
        }
        case IBLOrderSearchFieldTypeWorkOrderType: {
            [self.viewModel setWorkOrderType:object];
            break;
        }
        case IBLOrderSearchFieldTypeStartDate: {
            [self.viewModel setStartDate:object];
            break;
        }
        case IBLOrderSearchFieldTypeEndDate: {
            [self.viewModel setEndDate:object];
            break;
        }
        case IBLOrderSearchFieldTypeEnterpriseName:{
            [self.viewModel setEnterpriseName:object];
            break;
        }
        case IBLOrderSearchFieldTypeEnterpriseContact: {
            [self.viewModel setEnterpriseContact:object];
            break;
        }

        case IBLOrderSearchFieldTypeCustType: {
            [self.viewModel setCustType:[object integerValue]];
            break;
        }
    }
}

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesOfOrderSearchTableView:(IBLOrderSearchTableViewController *)controller {
    return [self.viewModel workOrderBizTypesStatus:self.viewModel.searchResult.type.status];
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypesOfOrderSearchTableView:(IBLOrderSearchTableViewController *)controller {
    return [self.viewModel workOrderTypes];
}

- (void)orderSearchTableviewDidEndSearch:(IBLOrderSearchTableViewController *)controller {
    [self.delegate orderSearchViewController:self didSearchResult:self.viewModel.searchResult];
}


@end
