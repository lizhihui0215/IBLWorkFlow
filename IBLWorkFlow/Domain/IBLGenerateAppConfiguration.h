//
//  IBLGenerateAppConfiguration.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLOrder.h"

@interface IBLGenerateAppConfiguration : IBLUseCase

- (NSArray<IBLWorkOrderBussinessType *> *)allWorkOrderBizTypes;

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesWithStatus:(IBLWorkOrderStatus)status;

- (NSArray<IBLWorkOrderType *> *)workOrderTypes;

/**
 *  获取我的工单按钮操作
 *
 *  @param status  工单状态
 *  @param bizType 工单业务状态
 *
 *  @return 按钮操作
 */
- (NSArray<NSNumber *> *)mineOrderActionsWithStatus:(IBLOrderStatus)status
                                            bizType:(IBLWorkOrderBizStatus)bizType;

/**
 *  获取工单管理按钮操作
 *
 *  @param status  工单状态
 *  @param bizType 工单业务状态
 *
 *  @return 按钮操作
 */
- (NSArray<NSNumber *> *)managedOrderActionsWithStatus:(IBLOrderStatus)status
                                               bizType:(IBLWorkOrderBizStatus)bizType;

- (IBLOrderEffectType)defaultEffectType;

- (NSString *)defaultEffectDate;

- (IBLPayModel)payModel;
@end
