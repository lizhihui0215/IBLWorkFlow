//
//  IBLAddWorkOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/3/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLOrderRepository.h"

@interface IBLAddWorkOrder : IBLUseCase
- (void)addWorkOrderWith:(IBLAddWorkOrderInfo *)addWorkOrderInfo
         completeHandler:(void(^)(NSString *orderId, NSError *error)) completeHandler;
@end
