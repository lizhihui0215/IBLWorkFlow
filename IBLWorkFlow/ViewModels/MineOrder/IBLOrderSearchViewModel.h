//
//  IBLOrderSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"
#import "IBLOrder.h"
#include "IBLOrderSearchResult.h"


@interface IBLOrderSearchViewModel : PCCWListViewModel

@property(nonatomic, strong, readonly) IBLOrderSearchResult *searchResult;

- (instancetype)initWithSearchResult:(IBLOrderSearchResult *)searchResult;

+ (instancetype)modelWithSearchResult:(IBLOrderSearchResult *)searchResult;

- (void)setUsername:(NSString *)username;

- (void)setUserAccount:(NSString *)userAccount;

- (void)setStartDate:(NSString *)startDate;

- (NSString *)startDate;

- (NSString *)endDate;

- (void)setEndDate:(NSString *)endDate;

- (void)setWorkOrderBizType:(IBLWorkOrderBussinessType *)businessType;

- (void)setWorkOrderType:(IBLWorkOrderType *)workOrderType;

- (void)setUserPhone:(NSString *)userPhone;

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesStatus:(IBLWorkOrderStatus)status;

- (NSArray<IBLWorkOrderType *> *)workOrderTypes;

- (NSString *)userAccount;

- (NSString *)username;

- (NSString *)userPhone;

- (NSString *)workOrderType;

- (NSString *)workOrderBizType;

- (void)setEnterpriseName:(NSString *)string;

- (void)setEnterpriseContact:(NSString *)string;

- (void)setCustType:(NSInteger)i;

- (NSInteger)custType;

- (NSString *)enterPriseName;

- (NSString *)enterpriseContact;

- (NSArray<IBLWorkOrderBussinessType *> *)allWorkOrderBizTypes;
@end
