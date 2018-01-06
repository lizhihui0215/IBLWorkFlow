//
//  IBLAddWorkOrderTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//


#import "IBLRelateUser.h"
#import "IBLAppDelegate.h"

typedef NS_ENUM(NSInteger, IBLAddWorkOrderFieldType) {
    IBLAddWorkOrderFieldTypeWorkOrderType,
    IBLAddWorkOrderFieldTypeBizType,
    IBLAddWorkOrderFieldTypePriority,
    IBLAddWorkOrderFieldTypeFinishedDate,
    IBLAddWorkOrderFieldTypeRegion,
    IBLAddWorkOrderFieldTypeProduct,
    IBLAddWorkOrderFieldTypeCount,
    IBLAddWorkOrderFieldTypeUsername,
    IBLAddWorkOrderFieldTypePhone,
    IBLAddWorkOrderFieldTypeAddress,
    IBLAddWorkOrderFieldTypeUserIdentifier,
    IBLAddWorkOrderFieldTypeWorkOrderContent,
    IBLAddWorkOrderFieldTypeRelateUser,
    IBLAddWorkOrderFieldTypeHandleUser,
    IBLAddWorkOrderFieldTypeRemark,
    IBLAddWorkOrderFieldTypeCustType,
    IBLAddWorkOrderFieldTypeCertType,
    IBLAddWorkOrderFieldTypeEnterpriseName,
    IBLAddWorkOrderFieldTypeEnterpriseSampleName,
    IBLAddWorkOrderFieldTypeEnterpriseContact,
    IBLAddWorkOrderFieldTypeEnterpriseContactPhone,
    IBLAddWorkOrderFieldTypeEnterpriseAddress,

};

@class IBLAddWorkOrderTableViewController;

@protocol IBLAddWorkOrderTableViewControllerDelegate <NSObject>

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesOfTableView:(IBLAddWorkOrderTableViewController *)controller;

- (NSArray<IBLWorkOrderType *> *)workOrderTypesOfTableView:(IBLAddWorkOrderTableViewController *)controller;

- (void)addWorkOrderTableView:(IBLAddWorkOrderTableViewController *)controller
                    fieldType:(IBLAddWorkOrderFieldType)type
                   didEndEdit:(id)edit;

- (id)fieldOfAddWorkOrderTableView:(IBLAddWorkOrderTableViewController *)controller fieldType:(enum IBLAddWorkOrderFieldType)type;

- (void)addWorkOrderTableDidCommit:(IBLAddWorkOrderTableViewController *)controller;
@end

@interface IBLAddWorkOrderTableViewController : PCCWStaticTableViewController

@property (nonatomic,weak) id<IBLAddWorkOrderTableViewControllerDelegate> tableViewDelegate;

- (void)setRelateUser:(IBLRelateUser *)relateUser;

@end
