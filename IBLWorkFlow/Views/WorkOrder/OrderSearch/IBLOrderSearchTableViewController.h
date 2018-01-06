//
//  IBLOrderSearchTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//




@class IBLOrderSearchTableViewController;

typedef NS_ENUM(NSInteger, IBLOrderSearchFieldType) {
    IBLOrderSearchFieldTypeAccount,
    IBLOrderSearchFieldTypeUsername,
    IBLOrderSearchFieldTypePhone,
    IBLOrderSearchFieldTypeWorkOrderBizType,
    IBLOrderSearchFieldTypeWorkOrderType,
    IBLOrderSearchFieldTypeStartDate,
    IBLOrderSearchFieldTypeEndDate,
    IBLOrderSearchFieldTypeCustType,
    IBLOrderSearchFieldTypeEnterpriseName,
    IBLOrderSearchFieldTypeEnterpriseContact,
    
};

@protocol IBLOrderSearchTableViewControllerDataSource <NSObject>

- (id)textOfOrderSearchTableView:(IBLOrderSearchTableViewController *)controller
                       fieldType:(IBLOrderSearchFieldType)fieldType;

- (void)orderSearchTableView:(IBLOrderSearchTableViewController *)controller
                   fieldType:(IBLOrderSearchFieldType)type
               didEndEdit:(id)object;

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesOfOrderSearchTableView:(IBLOrderSearchTableViewController *)controller;

- (NSArray<IBLWorkOrderType *> *)workOrderTypesOfOrderSearchTableView:(IBLOrderSearchTableViewController *)controller;

- (void)orderSearchTableviewDidEndSearch:(IBLOrderSearchTableViewController *)controller;
@end


@interface IBLOrderSearchTableViewController : PCCWStaticTableViewController

@property (nonatomic, weak) id<IBLOrderSearchTableViewControllerDataSource> searchDataSource;

@end
