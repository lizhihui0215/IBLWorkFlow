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

typedef NS_ENUM(NSInteger, IBLSearchType) {
    IBLSearchTypeForward,
    IBLSearchTypeSend,
    IBLSearchTypeCreateAccountArea,
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
