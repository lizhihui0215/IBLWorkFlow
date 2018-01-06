//
//  IBLProductSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLProductSearchViewModel.h"


@interface IBLProductSearchViewModel ()

@property (nonatomic, strong) IBLFetchProduct *fetchProduct;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, assign) NSInteger regionId;

@end

@implementation IBLProductSearchViewModel

+ (instancetype)productSearchModelWithSearchType:(IBLSearchType)searchType
                                       productId:(NSInteger)productId
                                     regionId:(NSInteger)regionId
{
    return [[self alloc] initWithSearchType:searchType
                                  productId:productId
                                regionId:regionId];
}

- (instancetype)initWithSearchType:(IBLSearchType)searchType
                         productId:(NSInteger)productId
                       regionId:(NSInteger)regionId
{
    self = [super init];
    if (self) {
        self.searchType = searchType;
        self.productId = productId;
        self.regionId = regionId;
        self.fetchProduct = [[IBLFetchProduct alloc] init];
        PCCWSection *section = [PCCWSection sectionWithInfo:nil items:nil];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (NSString *)title{
    return @"销售品选择";
}

- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(PCCWViewModelCompleteHandler)handler{
    NSString *productName = searchInfo[kSearchProductName];
    [self.fetchProduct fetchProductsWithIsRefresh:isRefresh
                                        productId:self.productId
                                         regionId:self.regionId
                                      productName:productName
                                  completeHandler:^(NSArray<IBLProduct *> *products, NSError *error){
                                      PCCWSection *section = [self sectionAt:0];
                                      NSMutableArray<PCCWSectionItem *> *sectionItems = [self sectionItemsWithProducts:products];
                                      if (isRefresh) {
                                          section.items = sectionItems;
                                      }else{
                                          [section.items addObjectsFromArray:sectionItems];
                                      }
                                      handler(error);
                                  }];
}

- (NSMutableArray<PCCWSectionItem *> *)sectionItemsWithProducts:(NSArray<IBLProduct *> *)products {
    
    NSMutableArray<PCCWSectionItem *> *sectionItems = [NSMutableArray array];
    
    for (IBLProduct *product in products) {
        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:product selected:NO];
        [sectionItems addObject:item];
    }
    
    return sectionItems;
}

- (IBLProduct *)productAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSectionItem *item = [self sectionItemAtIndexPath:indexPath];
    
    return item.info;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath{
    return [self productAtIndexPath:indexPath].name;
}

- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath {
    return [self productAtIndexPath:indexPath];;
}

@end
