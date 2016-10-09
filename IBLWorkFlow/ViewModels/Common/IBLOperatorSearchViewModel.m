//
//  IBLOperatorSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOperatorSearchViewModel.h"

@interface IBLOperatorSearchViewModel ()

@property (nonatomic, strong) IBLFetchOperatorList *fetchOperator;

@property (nonatomic, strong, readwrite) IBLOrder *order;

@end

@implementation IBLOperatorSearchViewModel

- (instancetype)initWithWorkOrder:(IBLOrder *)order searchType:(IBLSearchType)searchType {
    self = [super init];
    if (self) {
        
        self.searchType = searchType;
        
        self.order = order;
        
        self.fetchOperator = [[IBLFetchOperatorList alloc] init];
        
        IBLSection *section = [IBLSection sectionWithInfo:nil items:nil];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (NSString *)title{
    return @"操作员";
}

+ (instancetype)operatorSearchModelWithOrder:(IBLOrder *)order searchType:(IBLSearchType)searchType {
    return [[self alloc] initWithWorkOrder:order searchType:searchType];
}

- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(IBLViewModelCompleteHandler)handler{
    NSString *operatorName = searchInfo[kSearchOperatorName];
    
    [self.fetchOperator fetchOperatorsWithIsRefresh:isRefresh
                                       operatorName:operatorName
                                    completeHandler:^(NSArray<IBLOperator *> *operators, NSError *error) {
                                        IBLSection *section = [self sectionAt:0];
                                        NSMutableArray<IBLSectionItem *> * sectionItems =[self sectionItemsWithOperators:operators];

                                        if (isRefresh) {
                                            section.items = sectionItems;
                                        }else{
                                            [section.items addObjectsFromArray:sectionItems];
                                        }
                                        
                                        handler(error);
                                    }];
}


- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath {
    return [self operatorAtIndexPath:indexPath];;
}

- (NSMutableArray<IBLSectionItem *> *)sectionItemsWithOperators:(NSArray<IBLOperator *> *)operators {
    
    NSMutableArray<IBLSectionItem *> *sectionItems = [NSMutableArray array];
    
    for (IBLOperator *operator in operators) {
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:operator selected:NO];
        [sectionItems addObject:item];
    }
    
    return sectionItems;
}

- (IBLOperator *)operatorAtIndexPath:(NSIndexPath *)indexPath{
    IBLSectionItem *sectionItem = [self sectionItemAtIndexPath:indexPath];
    
    return sectionItem.info;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {
    IBLOperator *operator = [self operatorAtIndexPath:indexPath];
    
    return operator.name;
}
@end
