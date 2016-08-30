//
//  IBLFetchOrderDetail.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLPayRepository.h"

@interface IBLFetchOrderDetail : IBLUseCase
- (void)fetchOrderDetailWithOrderNumber:(NSString *)orderNumber
                        completeHandler:(void (^)(IBLOrderDetail *, NSError *))handler;
@end
