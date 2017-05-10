//
//  IBLOrderSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLOrder.h"
#include "IBLOrderSearchResult.h"


@interface IBLOrderSearchViewModel : IBLListViewModel

@property(nonatomic, strong, readonly) IBLOrderSearchResult *searchResult;

- (instancetype)initWithSearchResult:(IBLOrderSearchResult *)searchResult;

+ (instancetype)modelWithSearchResult:(IBLOrderSearchResult *)searchResult;

- (void)setUsername:(NSString *)username;


- (void)setUserAccount:(NSString *)userAccount;

- (void)setWorkOrderBizType:(IBLWorkOrderBussinessType *)businessType;

- (void)setWorkOrderType:(IBLWorkOrderType *)workOrderType;

- (void)setStartDate:(NSString *)startDate;

- (void)setEndDate:(NSString *)endDate;

- (void)setUserPhone:(NSString *)userPhone;

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesStatus:(IBLWorkOrderStatus)status;

- (NSArray<IBLWorkOrderType *> *)workOrderTypes;

- (NSString *)userAccount;

- (NSString *)username;

- (NSString *)userPhone;

- (NSString *)workOrderType;

- (NSString *)workOrderBizType;

- (NSString *)startDate;

- (NSString *)endDate;

- (void)setEnterpriseName:(NSString *)string;

- (void)setEnterpriseContact:(NSString *)string;

- (void)setCustType:(NSInteger)i;

- (NSInteger)custType;

- (NSString *)enterPriseName;

- (NSString *)enterpriseContact;
@end
