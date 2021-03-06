//
//  IBLHandleOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@class IBLOrder;
@interface IBLHandleOrder : IBLUseCase

- (void)handleOrderWithOrder:(IBLOrder *)order markHandle:(NSString *)markHandle servId:(NSString *)servId content:(NSString *)content completeHandler:(void (^)(NSError *))handler;
@end
