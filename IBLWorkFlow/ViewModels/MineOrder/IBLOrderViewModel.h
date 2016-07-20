//
//  IBLOrderViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLFetchOrder.h"
#import "IBLOrderSearchResult.h"
@class IBLOperator;

typedef NS_ENUM(NSInteger, IBLOrderType) {
    IBLOrderTypeMine,
    IBLOrderTypeManage
};

@interface IBLOrderViewModel : IBLListViewModel

@property (assign, nonatomic) IBLOrderType type;

@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithOrderType:(IBLOrderType)type;

- (IBLOrderStatus)status;

- (void)fetchOrderListWithIndex:(NSInteger)index isRefresh:(BOOL)isRefresh completeHandler:(IBLViewModelCompleteHandler)handler;

- (void)setSearchResult:(IBLOrderSearchResult *)searchResult;

- (IBLOrderSearchResult *)searchResult;

- (NSString *)workOrderTypAtIndexPath:(NSIndexPath *)idnexPath;

- (NSString *)usernameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath;

- (IBLPriorityStatus)orderPriorityAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray<NSString *> *)orderActionsTitlesAtIndexPath:(NSIndexPath *)indexPath;

- (IBLOrderAction)actionInIndexPath:(NSIndexPath *)indexPath atIndex:(NSInteger)index;

- (NSArray<NSString *> *)segmentedControlTitles;

- (NSString *)actionTitleWith:(IBLOrderAction)action
                  atIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)actionImageWith:(IBLOrderAction)action;

- (NSString *)title;

- (IBLOrder *)orderAtIndexPath:(NSIndexPath *)indexPath;

- (void)forwardWithOrder:(IBLOrder *)order
                operator:(IBLOperator *)operator
                 content:(NSString *)content
         completehandler:(void (^) (NSError *error))handler;

- (NSString *)placeHolderWith:(IBLOrderAction)action
                  atIndexPath:(NSIndexPath *)indexPath;

- (void)handlerWithAction:(IBLOrderAction)action indexPath:(NSIndexPath *)indexPath completeHandler:(void (^)(NSError *))handler;
@end
