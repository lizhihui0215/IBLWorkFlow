//
//  IBLAddWorkOrderViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/28/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAddWorkOrderViewModel.h"
#import "IBLAddWorkOrder.h"

@interface IBLAddWorkOrderViewModel ()

@property (nonatomic, strong) IBLAddWorkOrderResult *result;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@property (nonatomic, strong) IBLAddWorkOrder *addWorkOrder;

@end

@implementation IBLAddWorkOrderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result = [[IBLAddWorkOrderResult alloc] init];
        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
        self.addWorkOrder = [[IBLAddWorkOrder alloc] init];
    }
    return self;
}

- (IBLWorkOrderType *)workOrderType {
    return self.result.type;
}

- (IBLWorkOrderBussinessType *)workOrderBizType {
    return self.result.bizType;
}


- (void)setWorkOrderType:(IBLWorkOrderType *)type {
    self.result.type = type;
}

- (void)setWorkOrderBizType:(IBLWorkOrderBussinessType *)type {
    self.result.bizType = type;
}

- (void)setPriority:(IBLPriorityStatus)i {
    self.result.priority = i;
}

- (void)setFinishedDate:(NSString *)string {
    self.result.finishedDate = string;
}

- (void)setRegion:(IBLRegion *)region {
    self.result.region = region;
}

- (IBLRegion *)region{
    return self.result.region;
}

- (void)setProduct:(IBLProduct *)product {
    self.result.product = product;
}

- (void)setCount:(NSString *)string {
    self.result.count = [string integerValue];
}

- (void)setUsername:(NSString *)string {
    self.result.name = string;
}

- (void)setPhone:(NSString *)string {
    self.result.phone = string;
}

- (void)setAddress:(NSString *)string {
    self.result.address = string;
}

- (void)setUserIdentifier:(NSInteger )string {
    self.result.userIdentifier = string;
}

- (void)setWorkOrderContent:(NSString *)string {
    self.result.workOrderContent = string;
}

- (void)setRelateUser:(IBLRelateUser *)user {
    self.result.relateUser = user;
}

- (void)setOperator:(IBLOperator *)anOperator {
    self.result.oper = anOperator;
}

- (void)setRemark:(NSString *)string {
    self.result.remark = string;
}

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypes {
    IBLWorkOrderType *workOrderType = [self workOrderType];
    return [self.generateAppConfiguration workOrderBizTypesWithStatus:workOrderType.status];
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypes {
    return [self.generateAppConfiguration workOrderTypes];
}

- (void)commitWithCompleteHandler:(IBLViewModelCompleteHandler)handler {
    IBLAddWorkOrderInfo *info = [[IBLAddWorkOrderInfo alloc] init];
    info.orderType = self.result.type.status;
    info.bizType = self.result.bizType.status;
    info.priority = self.result.priority;
    info.preFinishTime = self.result.finishedDate;
    info.orderContent = self.result.workOrderContent;
    info.servId = self.result.relateUser.servId;
    info.handleOperId = self.result.oper.identifier;
    info.offerId = self.result.product.identifier;
    info.nodeId = self.result.region.identifier;
    info.username = self.result.name;
    info.userIdentifier = self.result.userIdentifier;
    info.phone = self.result.phone;
    info.address = self.result.address;
    info.remark = self.result.remark;
    info.buyLength = self.result.count;
    [self.addWorkOrder addWorkOrderWith:info
                        completeHandler:^(NSString *orderId, NSError *error) {
                            handler(error);
                        }];
}
@end
