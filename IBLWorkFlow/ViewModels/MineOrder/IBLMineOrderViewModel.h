//
//  IBLMineOrderViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLFetchOrder.h"


@interface IBLMineOrderViewModel : IBLListViewModel

- (IBLOrderStatus)statusWithIndex:(NSInteger)index;

- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch
                        completeHandler:(IBLViewModelCompleteHandler)handler;
@end
