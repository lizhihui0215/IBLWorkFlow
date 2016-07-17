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

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypes;

- (NSArray<IBLWorkOrderType *> *)workOrderTypes;

- (NSArray<NSNumber *> *)orderOperationButtonsWithStatus:(IBLOrderStatus)status;
@end
