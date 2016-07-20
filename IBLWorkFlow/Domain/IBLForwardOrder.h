//
//  IBLMethodOfForwardOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@class IBLOrder;
@class IBLOperator;

@interface IBLForwardOrder : IBLUseCase

- (void)forwardOrderWith:(IBLOrder *)order
                operator:(IBLOperator *)operator
                 content:(NSString *)content
         completeHandler:(void (^)(NSError *))handler;

@end
