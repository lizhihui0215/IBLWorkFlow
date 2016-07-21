//
//  IBLRegionSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRegionSearchViewModel.h"
#import "IBLFetchRegion.h"
#import "IBLRegion.h"

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
                                   NSMutableArray<IBLSectionItem *> *sectionItems =[self sectionItemsWithOperators:regions];
                                   if (isRefresh) {
                                       section.items = sectionItems;
                                   }else{
                                       [section.items addObjectsFromArray:sectionItems];
                                   }
                                   handler(error);
                               }];
}

- (NSMutableArray<IBLSectionItem *> *)sectionItemsWithOperators:(NSArray<IBLRegion *> *)operators {
    
    NSMutableArray<IBLSectionItem *> *sectionItems = [NSMutableArray array];
    
    for (IBLRegion *regions in operators) {
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:regions selected:NO];
        [sectionItems addObject:item];
    }
    
    return sectionItems;
}

@end
