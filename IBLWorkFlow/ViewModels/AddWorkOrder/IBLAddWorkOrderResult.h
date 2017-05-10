//
//  IBLAddWorkOrderResult.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/28/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBLRegion.h"
#import "IBLProduct.h"
#import "IBLRelateUser.h"
#import "IBLOperator.h"
#import "IBLOrder.h"

@interface IBLAddWorkOrderResult : NSObject

@property (nonatomic, strong) IBLWorkOrderType *type;

@property (nonatomic, strong) IBLWorkOrderBussinessType *bizType;

@property (nonatomic, strong) IBLRegion *region;

@property (nonatomic, strong) IBLProduct *product;

@property (nonatomic, strong) IBLRelateUser *relateUser;

@property (nonatomic, strong) IBLOperator *oper;

@property (nonatomic, assign) IBLPriorityStatus priority;

@property (nonatomic, copy) NSString *finishedDate;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger userIdentifier;

@property (nonatomic, copy) NSString *workOrderContent;

@property (nonatomic, copy) NSString *remark;

// 用户类型
@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, assign) NSString *companyName;

@property (nonatomic, copy) NSString *companyPhone;

@property (nonatomic, copy) NSString *companyContact;

@property (nonatomic, copy) NSString *companyAddress;
@property (nonatomic, copy) NSString *sampleComName;

@property(nonatomic) NSInteger certType;



@end
