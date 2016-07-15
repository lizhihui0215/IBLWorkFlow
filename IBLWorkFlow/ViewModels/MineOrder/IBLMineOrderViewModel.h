//
//  IBLMineOrderViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLFetchOrder.h"
#import "IBLOrderSearchResult.h"

@interface IBLMineOrderViewModel : IBLListViewModel

- (IBLOrderStatus)statusWithIndex:(NSInteger)index;

- (void)fetchMineOrderListWithIndex:(NSInteger)index isRefresh:(BOOL)isRefresh completeHandler:(IBLViewModelCompleteHandler)handler;

- (void)setSearchResult:(IBLOrderSearchResult *)searchResult index:(NSInteger)index;

- (IBLOrderSearchResult *)searchResultWithIndex:(NSInteger)index;

@end
