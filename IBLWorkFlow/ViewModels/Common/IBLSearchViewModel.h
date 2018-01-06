//
//  IBLSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"

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
     *  开户选择区域
     */
    IBLSearchTypeCreateAccountArea,
    /**
     *  开户选择销售品
     */
    IBLSearchTypeCreateAccountProduct,
    /**
     *  更换销售品选择区域
     */
    IBLSearchTypeExchangeProductArea,
    /**
     *  续费选择区域
     */
    IBLSearchTypeRenewArea,
    
    IBLSearchTypeAddOrderArea,
    
    IBLSearchTypeAddOrderProduct,
        
    IBLSearchTypeAddOrderOperator,
    /**
     *  更换销售品选择销售品
     */
    IBLSearchTypeExchangeProductProduct,
};

@class IBLSearchViewModel;

@protocol IBLSearchViewModelDelegate <NSObject>

@optional
- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(PCCWViewModelCompleteHandler)handler;

- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface IBLSearchViewModel : PCCWListViewModel<IBLSearchViewModelDelegate>

@property (nonatomic, assign) IBLSearchType searchType;

- (NSString *)title;

@end
