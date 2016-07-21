//
//  IBLSendOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
@class IBLOrder;
@class IBLOperator;

@interface IBLSendOrder : IBLUseCase

- (void)sendOrderWith:(IBLOrder *)order
             operator:(IBLOperator *)operator
              content:(NSString *)content
      completeHandler:(void (^)(NSError *))handler;
@end
