//
//  IBLOrderFlowViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"
#import "IBLFetchOrderFlow.h"

@interface IBLOrderFlowViewModel : PCCWListViewModel

- (instancetype)initWithOrder:(IBLOrder *)order;

- (void)startFetchWithCompleteHandler:(PCCWViewModelCompleteHandler)handler;

- (NSString *)statusAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)operatorNameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)suggestAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)handleDateAtIndexPath:(NSIndexPath *)indexPath;

- (IBLOrderFlow *)orderFlowAtIndexPath:(NSIndexPath *)indexPath;
@end
