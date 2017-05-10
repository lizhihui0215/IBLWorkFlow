//
//  IBLAddWorkOrderViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/28/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewModel.h"
#import "IBLAddWorkOrderResult.h"
#import "IBLGenerateAppConfiguration.h"


@interface IBLAddWorkOrderViewModel : IBLViewModel

- (IBLWorkOrderType *)workOrderType;

- (IBLWorkOrderBussinessType *)workOrderBizType;

- (void)setWorkOrderType:(IBLWorkOrderType *)type;

- (void)setWorkOrderBizType:(IBLWorkOrderBussinessType *)type;

- (void)setPriority:(IBLPriorityStatus)i;

- (void)setFinishedDate:(NSString *)string;

- (IBLRegion *)region;

- (void)setRegion:(IBLRegion *)region;

- (void)setProduct:(IBLProduct *)product;

- (void)setCount:(NSString *)string;

- (void)setUsername:(NSString *)string;

- (void)setPhone:(NSString *)string;

- (void)setAddress:(NSString *)string;

- (void)setUserIdentifier:(NSInteger)string;

- (void)setWorkOrderContent:(NSString *)string;

- (void)setRelateUser:(IBLRelateUser *)user;

- (void)setOperator:(IBLOperator *)anOperator;

- (void)setRemark:(NSString *)string;

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypes;

- (NSArray<IBLWorkOrderType *> *)workOrderTypes;

- (void)commitWithCompleteHandler:(IBLViewModelCompleteHandler)handler;

- (NSInteger)custType;

- (void)setCustType:(NSInteger)value;

- (void)setCertType:(NSInteger)value;

- (NSInteger)certType;

- (void)setEnterpriseName:(NSString *)value;

- (void)setEnterpriseSample:(NSString *)val;

- (void)setEnterpriseContact:(NSString *)val;

- (void)setEnterpriseContactPhone:(NSString *)val;

- (void)setEnterpriseAddress:(NSString *)val;
@end
