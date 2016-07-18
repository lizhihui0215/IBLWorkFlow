//
//  IBLSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"

typedef NS_ENUM(NSInteger, IBLSearchType) {
    IBLSearchTypeForward,
};

@class IBLSearchViewModel;

@protocol IBLSearchViewModelDelegate <NSObject>

@optional
- (void)fetchSearchContentWith:(IBLViewModelCompleteHandler)handle;


@end

@interface IBLSearchViewModel : IBLListViewModel<IBLSearchViewModelDelegate>

@property (nonatomic, assign, readonly) IBLSearchType searchType;

@end
