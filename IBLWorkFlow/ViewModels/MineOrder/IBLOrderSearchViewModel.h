//
//  IBLOrderSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLOrder.h"


@interface IBLOrderSearchResult : NSObject;

@property (nonatomic, assign) IBLOrderStatus status;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) IBLWorkOrderType *type;

@property (nonatomic, copy) IBLWorkOrderBussinessType *bizType;

@property (nonatomic, copy) NSString *dateRange;

+ (instancetype)initWithStatus:(IBLOrderStatus)status
             resultWithAccount:(NSString *)account
                      username:(NSString *)username
                         phone:(NSString *)phone
                          type:(IBLWorkOrderType *)type
                       bizType:(IBLWorkOrderBussinessType *)bizType
                     dateRange:(NSString *)dateRange;

@end

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

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypes;

- (NSArray<IBLWorkOrderType *> *)workOrderTypes;
@end
