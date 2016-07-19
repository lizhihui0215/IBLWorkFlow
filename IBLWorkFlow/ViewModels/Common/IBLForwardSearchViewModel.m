//
//  IBLForwardSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLForwardSearchViewModel.h"

@interface IBLForwardSearchViewModel ()
{
    NSMutableArray *_dataSource;
}
@property (nonatomic, strong) IBLFetchOperatorList *fetchOperator;

@property (nonatomic, strong, readwrite) IBLOrder *order;
@end

@implementation IBLForwardSearchViewModel

- (NSMutableArray *)dataSource{
    return _dataSource;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
}

- (instancetype)initWithWorkOrder:(IBLOrder *)order
{
    self = [super init];
    if (self) {
        self.order = order;
        
        self.fetchOperator = [[IBLFetchOperatorList alloc] init];
        
        IBLSection *section = [IBLSection sectionWithInfo:nil items:nil];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (IBLSearchType)searchType{
    return IBLSearchTypeForward;
}

+ (instancetype)forwardSearchModelWithOrder:(IBLOrder *)order {
    return [[self alloc] initWithWorkOrder:order];
}

- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(IBLViewModelCompleteHandler)handler{
    NSString *operatorName = searchInfo[kSearchOperatorName];
    
    [self.fetchOperator fetchOperatorsWithIsRefresh:isRefresh
                                       operatorName:operatorName
                                    completeHandler:^(NSArray<IBLOperator *> *operators, NSError *error) {
                                        if (isRefresh) {
                                            IBLSection *section = [self sectionAt:0];
                                            section.items = [self sectionItemsWithOperators:operators];
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
