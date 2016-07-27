//
//  IBLSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"

static NSString *const kSearchOperatorName = @"operatorName";
static NSString *const kSearchAreaName = @"areaName";
static NSString *const kSearchProductName = @"productName";

/**
 *  检索类型
 */
typedef NS_ENUM(NSInteger, IBLSearchType) {
    /**
     *  转发
     */
    IBLSearchTypeForward,
    /**
     *  派发
     */
    IBLSearchTypeSend,
    /**
     *  开户选择小区
     */
    IBLSearchTypeCreateAccountArea,
    /**
     *  开户选择销售品
     */
    IBLSearchTypeCreateAccountProduct,
    /**
     *  更换销售品选择小区
     */
    IBLSearchTypeExchangeProductArea,
    /**
     *  续费选择小区
     */
    IBLSearchTypeRenewArea,
};

@class IBLSearchViewModel;

@protocol IBLSearchViewModelDelegate <NSObject>

@optional
- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(IBLViewModelCompleteHandler)handler;

- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface IBLSearchViewModel : IBLListViewModel<IBLSearchViewModelDelegate>

@property (nonatomic, assign) IBLSearchType searchType;

@end
