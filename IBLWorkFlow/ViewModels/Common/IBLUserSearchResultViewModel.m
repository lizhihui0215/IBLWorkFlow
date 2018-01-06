//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"
#import "IBLUserSearchResultViewModel.h"
#import "IBLUserListRepository.h"
#import "IBLRelateUser.h"
#import "IBLFetchUserList.h"

@interface IBLUserSearchResultViewModel ()
{
    NSMutableArray *_dataSource;
}
@property(nonatomic, strong) IBLFetchUserList *fetchUserList;
@end

@implementation IBLUserSearchResultViewModel

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
}

- (NSMutableArray *)dataSource{
    return _dataSource;
}


- (instancetype)initWithSearchType:(IBLUserSearchType)searchType
                      searchResult:(IBLUserSearchResult *)searchResult {
    self = [super init];
    if (self) {
        self.searchType = searchType;
        self.searchResult = searchResult;
        self.fetchUserList = [[IBLFetchUserList alloc] init];
        PCCWSection *section = [PCCWSection sectionWithInfo:nil items:nil];
        
        [self.dataSource addObject:section];

    }

    return self;
}

+ (instancetype)modelWithSearchType:(IBLUserSearchType)searchType
                       searchResult:(IBLUserSearchResult *)searchResult {
    return [[self alloc] initWithSearchType:searchType searchResult:searchResult];
}

- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath {
    return [self relateUserAtIndexPath:indexPath];
}


- (NSString *)accountAtIndexPath:(NSIndexPath *)indexPath {
    IBLRelateUser *user = [self relateUserAtIndexPath:indexPath];
    return user.account;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {
    IBLRelateUser *user = [self relateUserAtIndexPath:indexPath];
    return user.username;
}

- (IBLRelateUser *)relateUserAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSectionItem *sectionItem = [self sectionItemAtIndexPath:indexPath];
    
    return sectionItem.info;
}


- (void)reloadWithIsRefresh:(BOOL)isRefresh
            completeHandler:(void (^)(NSError *))handler {
    IBLFetchUserListInfo *fetch = [IBLFetchUserListInfo infoWithAccount:self.searchResult.account
                                                               username:self.searchResult.username
                                                                  phone:self.searchResult.phone
                                                               areaName:self.searchResult.region.name
                                                         areaIdentifier:self.searchResult.region.identifier
                                                         userIdentifier:self.searchResult.userIdentifier
                                                                address:self.searchResult.address];
    fetch.comName = self.searchResult.comName;
    fetch.comContact = self.searchResult.comContact;
    fetch.comContactPhone = self.searchResult.comContactPhone;
    fetch.custType = self.searchResult.custType;
    
    [self.fetchUserList fetchUserListWithIsRefresh:isRefresh
                                       fetchResult:fetch
                                   completeHandler:^(NSArray<IBLRelateUser *> *users, NSError *error){
                                       PCCWSection *section = [self sectionAt:0];
                                       NSMutableArray<PCCWSectionItem *> * sectionItems =[self sectionItemsWithRelateUsers:users];

                                       if (isRefresh) {
                                           section.items = sectionItems;
                                       }else{
                                           [section.items addObjectsFromArray:sectionItems];
                                       }

                                       handler(error);
                                   }];
}

- (NSMutableArray<PCCWSectionItem *> *)sectionItemsWithRelateUsers:(NSArray<IBLRelateUser *> *)relateUsers{
    NSMutableArray<PCCWSectionItem *> *sectionItems = [NSMutableArray array];
    
    for (IBLRelateUser *relateUser in relateUsers) {
        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:relateUser selected:NO];
        [sectionItems addObject:item];
    }
    
    return sectionItems;
}

- (NSInteger)identifierAtIndexPath:(NSIndexPath *)indexPath {
    return [self relateUserAtIndexPath:indexPath].servId;
}
@end
