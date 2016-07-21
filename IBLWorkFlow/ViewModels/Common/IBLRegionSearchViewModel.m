//
//  IBLRegionSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRegionSearchViewModel.h"
#import "IBLFetchRegion.h"

@interface IBLRegionSearchViewModel ()

@property (nonatomic, strong) IBLFetchRegion *fetchRegion;

@end

@implementation IBLRegionSearchViewModel

+ (instancetype)regionSearchModelWithSearchType:(IBLSearchType)searchType{
    return [[self alloc] initWithSearchType:searchType];
}

- (instancetype)initWithSearchType:(IBLSearchType)searchType
{
    self = [super init];
    if (self) {
        self.searchType = searchType;
        
        self.fetchRegion = [[IBLFetchRegion alloc] init];
        
        IBLSection *section = [IBLSection sectionWithInfo:nil items:nil];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(IBLViewModelCompleteHandler)handler{
    NSString *regionName = searchInfo[kSearchAreaName];
    [self.fetchRegion fetchRegionWithIsRefresh:isRefresh
                                    regionname:regionName
                               completeHandler:^(NSArray<IBLRegion *> *regions, NSError *error){
                                   IBLSection *section = [self sectionAt:0];
                                   NSMutableArray<IBLSectionItem *> *sectionItems = [self sectionItemsWithRegions:regions];
                                   if (isRefresh) {
                                       section.items = sectionItems;
                                   }else{
                                       [section.items addObjectsFromArray:sectionItems];
                                   }
                                   handler(error);
                               }];
}

- (NSMutableArray<IBLSectionItem *> *)sectionItemsWithRegions:(NSArray<IBLRegion *> *)regions {
    
    NSMutableArray<IBLSectionItem *> *sectionItems = [NSMutableArray array];
    
    for (IBLRegion *region in regions) {
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:region selected:NO];
        [sectionItems addObject:item];
    }
    
    return sectionItems;
}

- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath {
    return [self regionAtIndexPath:indexPath];;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {
    IBLRegion  *region = [self regionAtIndexPath:indexPath];

    return region.name;
}

- (IBLRegion *)regionAtIndexPath:(NSIndexPath *)indexPath {
    IBLSectionItem  *item = [self sectionItemAtIndexPath:indexPath];

    return item.info;
}
@end
