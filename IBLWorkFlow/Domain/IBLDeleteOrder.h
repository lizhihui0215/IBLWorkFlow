//
//  IBLMethodOfDeleteOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@class IBLOrder;

@interface IBLDeleteOrder : IBLUseCase

- (void)deleteOrderWithOrder:(IBLOrder *)order
             completeHandler:(void (^)(NSError *))handler;
@end
