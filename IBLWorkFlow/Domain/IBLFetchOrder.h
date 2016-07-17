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

/**
 *  fetch mine order list from server
 *
 *  @param isRefresh YES fetch from the beginning, or NO fetch the next page
 *  @param fetch     the info used to fetch
 */
- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch
                        completeHandler:(void (^)(NSMutableArray<IBLOrder *> *, NSError *error))handler;

@end
