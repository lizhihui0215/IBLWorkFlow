//
//  IBLOrderFlowViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLFetchOrderFlow.h"

@interface IBLOrderFlowViewModel : IBLListViewModel

- (instancetype)initWithOrder:(IBLOrder *)order;

- (void)startFetchWithCompleteHandler:(IBLViewModelCompleteHandler)handler;

- (NSString *)statusAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)operatorNameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)suggestAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)handleDateAtIndexPath:(NSIndexPath *)indexPath;
@end