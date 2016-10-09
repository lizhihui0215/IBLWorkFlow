//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLUserSearchViewModel.h"


@interface IBLUserSearchResultViewModel : IBLListViewModel

@property (nonatomic, assign) IBLUserSearchType searchType;

@property (nonatomic, strong) IBLUserSearchResult *searchResult;

+ (instancetype)modelWithSearchType:(IBLUserSearchType)searchType
                       searchResult:(IBLUserSearchResult *)searchResult;

- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)accountAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;

- (void)reloadWithIsRefresh:(BOOL)isRefresh completeHandler:(void (^)(NSError *))handler;
@end