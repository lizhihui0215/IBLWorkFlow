//
//  IBLFetchOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLOrderRepository.h"

@interface IBLFetchOrder : IBLUseCase

- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch
                        completeHandler:(void (^)(NSArray *orderList, NSError *error))handler;

@end
