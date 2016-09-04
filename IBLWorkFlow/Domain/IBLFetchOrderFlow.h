//
//  IBLFetchOrderFlow.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLOrderRepository.h"

@interface IBLFetchOrderFlow : IBLUseCase
- (void)fetchOrderFlowWithOrderIdentifier:(NSInteger)orderIdentifier
                          completeHandler:(void (^)(NSMutableArray<IBLOrderFlow *> *, NSError *))handler;
@end
